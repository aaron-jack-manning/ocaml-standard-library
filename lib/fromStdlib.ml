(* https://github.com/ocaml/ocaml/blob/cce52acc7c7903e92078e9fe40745e11a1b944f0/stdlib/pervasives.ml *)

let failwith = Stdlib.failwith
let printf = Printf.printf

external ( |> ) : 'a -> ('a -> 'b) -> 'b = "%revapply"
external ignore : 'a -> unit = "%ignore"


external stdlib_int_of_char : char -> int = "%identity"
let stdlib_char_of_int = char_of_int
let stdlib_string_of_bool = string_of_bool
let stdlib_bool_of_string = bool_of_string
let stdlib_bool_of_string_opt = bool_of_string_opt
let stdlib_string_of_int = string_of_int
external stdlib_int_of_string : string -> int = "caml_int_of_string"
let stdlib_int_of_string_opt = int_of_string_opt
let stdlib_string_of_float = string_of_float
external stdlib_float_of_string : string -> float = "caml_float_of_string"
let stdlib_float_of_string_opt = float_of_string_opt

external stdlib_plus_int : int -> int -> int = "%addint"
external stdlib_minus_int : int -> int -> int = "%subint"
external stdlib_multiply_int : int -> int -> int = "%mulint"
external stdlib_divide_int : int -> int -> int = "%divint"
external stdlib_mod_int : int -> int -> int = "%modint"

external stdlib_plus_float : float -> float -> float = "%addfloat"
external stdlib_minus_float : float -> float -> float = "%subfloat"
external stdlib_multiply_float : float -> float -> float = "%mulfloat"
external stdlib_divide_float : float -> float -> float = "%divfloat"

external stdlib_string_length : string -> int = "%string_length"

external bytes_create : int -> bytes = "caml_create_bytes"
external string_blit : string -> int -> bytes -> int -> int -> unit
                     = "caml_blit_string" [@@noalloc]
external bytes_blit : bytes -> int -> bytes -> int -> int -> unit
                        = "caml_blit_bytes" [@@noalloc]
external bytes_unsafe_to_string : bytes -> string = "%bytes_to_string"

let stdlib_string_concat s1 s2 =
    let l1 = stdlib_string_length s1 and l2 = stdlib_string_length s2 in
    let s = bytes_create (l1 + l2) in
    string_blit s1 0 s 0 l1;
    string_blit s2 0 s l1 l2;
    bytes_unsafe_to_string s

external ( = ) : 'a -> 'a -> bool = "%equal"
external ( <> ) : 'a -> 'a -> bool = "%notequal"

external ( < ) : 'a -> 'a -> bool = "%lessthan"
external ( > ) : 'a -> 'a -> bool = "%greaterthan"
external ( <= ) : 'a -> 'a -> bool = "%lessequal"
external ( >= ) : 'a -> 'a -> bool = "%greaterequal"

external not : bool -> bool = "%boolnot"
external ( or ) : bool -> bool -> bool = "%sequor"
external ( & ) : bool -> bool -> bool = "%sequand"



