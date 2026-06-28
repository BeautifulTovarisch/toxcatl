open Toxcatl

let () =
  suite "test for equality" (fun _ -> [
    test_eq ~fmt:"expected %i to equal %i" (-1) 0;
    test_eq ~fmt:"expected: %s. Got %s" "a" "b";
    test_eq ~fmt:"expected: %s. Got %s" "xyz" "abc";
    test_eq "xyz" "abc";
  ]);
  suite "test something else" (fun _ -> [
    test_eq ~fmt:"expected first %i to equal second %i" 1 2;
    test_eq ~fmt:"expected %.3f to equal %.3f" 0.1 0.2;
    (* test_eq ~ppf:list_printer [] [1;2] *)
    (* test_eq ~ppf:(mk_ppf "expected %s to equal %s") [] [1;2] *)
  ])

let pp_list fmt l =
  (Format.pp_print_list (fun ppf x -> Format.fprintf ppf fmt x)) l

let pretty_list fmt lst =
  Format.printf "@[[%a]@]@." (pp_list fmt) lst

let pp_lists ppf fmt a b =
  Format.printf ppf (pp_list fmt) a (pp_list fmt) b

let () =
  pp_lists "@[expected [%a] got [%a]@]@." "%d;" [] [1; 2; 3];
  pretty_list "%d;" [1; 2; 3];
  pretty_list "%d;" [3; 4; 5];;
