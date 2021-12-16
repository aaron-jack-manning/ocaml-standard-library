open Types

(* Combines two trees of the same type, with the specified value at the new top node. Runs in O(1). *)
val combine : 'a tree -> 'a tree -> 'a -> 'a tree