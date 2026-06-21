(* TODO: I *almost* eliminated some of this duplication via functors, but ran
   into issues with different arity ('a t vs ('a, 'b) t). Reconsider design in
   the future *)

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

  let compose fn s1 s2 =
    let (a, res1), (b, res2) = s1, s2 in
    Test (fn a b, res1 @ res2)

  let ( >>= ) = bind
  let ( >=> ) = compose
end
