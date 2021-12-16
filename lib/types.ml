type 'a queue = { front : 'a list; back : 'a list }

type 'a result =
    | Error of string
    | Success of 'a

type 'a stack =
    | Empty
    | Stacked of 'a * 'a stack

type 'a tree =
    | Leaf
    | Branch of 'a * 'a tree list