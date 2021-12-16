(** Purely functional queue, implemented as a pair of lists. *)
type 'a queue = { front : 'a list; back : 'a list }

type 'a result =
    | Error of string
    | Success of 'a

(** Purely functional stack. *)
type 'a stack =
    | Empty
    | Stacked of 'a * 'a stack

(* A purely functional tree with arbitrarily many branches at each node. *)
type 'a tree =
    | Leaf
    | Branch of 'a * 'a tree list