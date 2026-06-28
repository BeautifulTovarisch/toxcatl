(** Toxcatl
  * A simple testing library. *)

(** [Case] represents a single test case *)
module Case : sig
  (** [t] is whether the test passed or failed *)
  type 'a t = Pass | Fail of 'a

  (** [bind] chains a sequence of tests *)
  val bind : 'a t -> ('a -> 'b t) -> 'b t

  (** [compose] combines the results of tests *)
  val compose : ('a -> 'a -> 'a) -> 'a t -> 'a t -> 'a t

  val ( >>= ) : 'a t -> ('a -> 'b t) -> 'b t
  val ( >=> ) : ('a -> 'a -> 'a) -> 'a t -> 'a t -> 'a t
end

(** [Suite] is a collection of test [Case]s *)
module Suite : sig
  type ('a, 'b) t = Test of 'a * 'b Case.t list

  (** [bind] chains together a [Suite]s *)
  val bind : ('a, 'b) t -> ('a -> 'b Case.t list -> 'c) -> 'c

  val ( >>= ) : ('a, 'b) t -> ('a -> 'b Case.t list -> 'c) -> 'c
end

module C = Case
module S = Suite

(** [suite] runs a suite of unit tests and outputs the result *)
val suite : string -> (unit -> string C.t list) -> unit

(** [test_eq] is a helper function to compare [a] and [b], returning [Pass] if
  * [a] equals [b] or a [Fail] containing the [fmt] message *)
val test_eq : 'a -> 'a -> ('a -> 'a -> 'b, unit, string) format -> 'b C.t
