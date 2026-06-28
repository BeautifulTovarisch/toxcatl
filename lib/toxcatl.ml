(* TODO: I *almost* eliminated some of this duplication via functors, but ran
   into issues with different arity ('a t vs ('a, 'b) t). Reconsider design in
   the future *)

open Format

module Case = struct
  type 'a t = Pass | Fail of 'a

  let bind m f = match m with
  | Pass -> Pass
  | Fail(e) -> f e

  let compose fn a b = match a, b with
  | Pass, f | f, Pass -> f
  | f1, f2 ->
      bind f1 (fun e1 ->
      bind f2 (fun e2 ->
        Fail(fn e1 e2)))

  let ( >>= ) = bind
  let ( >=> ) = compose
end

module Suite = struct
  type ('a, 'b) t = Test of 'a * 'b Case.t list

  let bind m f =
    let Test(a, res) = m in f a res

  let ( >>= ) = bind
end

module C = Case
module S = Suite

let print_case = function
  | Case.Pass -> ()
  | Case.Fail(e) -> printf "FAIL: %s@ " e

(* Format.printf "@[[%a]@]@." (Format.pp_print_list (fun out x -> Format.fprintf out "%d;" x)) [1; 2; 3];; *)

let print_list fmt l =
  let printer = (fun out x -> Format.fprintf out fmt x) in
  Format.printf "@[%a]@]@." (Format.pp_print_list printer) l

let suite name f =
  let open S in
  Test(name, f ()) >>= fun name res ->
    printf "@[<v>SUITE: %s@;" name;
    printf "@[<v 1> ";
    List.iter print_case res;
    printf "@]";
    printf "@]";
    printf "@."

let test_eq ?fmt a b = match Stdlib.compare a b with
| 0 -> C.Pass
| _ -> match fmt with
| None -> C.Fail("expected values to be equal")
| Some(f) -> C.Fail(Format.sprintf f a b)
