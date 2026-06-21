(** Toxcatl
    A simple testing library. *)

(** [Case] represents a single test case *)
module Case : sig
  (** [t] is whether the test passed or failed *)
  type 'a t = Pass | Fail of 'a

  (** [bind] chains a sequence of tests *)
  val bind : 'a t -> ('a -> 'b t) -> 'b t

  (** [compose] combines the results of tests *)
  val compose : ('a -> 'a -> 'a) -> 'a t -> 'a t -> 'a t
end

(** [Suite] is a collection of test [Case]s *)
module Suite : sig
  type ('a, 'b) t = Test of 'a * 'b Case.t list

  (** [bind] chains together a [Suite]s *)
  val bind : ('a, 'b) t -> ('a -> 'b Case.t list -> 'c) -> 'c

  (** [compose] combines two test suites  *)
  val compose : ('a -> 'b -> 'c) -> 'a * 'd Case.t list -> 'b * 'd Case.t list -> ('c, 'd) t
end
