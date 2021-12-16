open List
open Types

let combine (tr1 : 'a tree) (tr2 : 'a tree) (topBranch : 'a) : 'a tree =
    Branch (topBranch, tr1 :: tr2 :: [])