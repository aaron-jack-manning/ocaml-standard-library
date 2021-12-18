(* https://github.com/ocaml/ocaml/blob/cce52acc7c7903e92078e9fe40745e11a1b944f0/stdlib/pervasives.ml *)

let failwith = Stdlib.failwith
let printf = Printf.printf

external ( |> ) : 'a -> ('a -> 'b) -> 'b = "%revapply"

external stdlib_plus_int : int -> int -> int = "%addint"
external stdlib_minus_int : int -> int -> int = "%subint"
external stdlib_multiply_int : int -> int -> int = "%mulint"
external stdlib_divide_int : int -> int -> int = "%divint"
external stdlib_mod_int : int -> int -> int = "%modint"

external stdlib_plus_float : float -> float -> float = "%addfloat"
external stdlib_minus_float : float -> float -> float = "%subfloat"
external stdlib_multiply_float : float -> float -> float = "%mulfloat"
external stdlib_divide_float : float -> float -> float = "%divfloat"

external ( = ) : 'a -> 'a -> bool = "%equal"
external ( <> ) : 'a -> 'a -> bool = "%notequal"

external ( < ) : 'a -> 'a -> bool = "%lessthan"
external ( > ) : 'a -> 'a -> bool = "%greaterthan"
external ( <= ) : 'a -> 'a -> bool = "%lessequal"
external ( >= ) : 'a -> 'a -> bool = "%greaterequal"

external not : bool -> bool = "%boolnot"
external ( or ) : bool -> bool -> bool = "%sequor"
external ( & ) : bool -> bool -> bool = "%sequand"