open Toxcatl

let () =
  suite "test for equality" (fun _ -> [
    test_eq (-1) 0 "expected %i to equal %i";
    test_eq "a" "b" "expected: %s. Got %s";
    test_eq "xyz" "abc" "expected: %s. Got %s"
  ]);
  suite "test something else" (fun _ -> [
    test_eq 1 2 "expected first %i to equal second %i";
  ]);
