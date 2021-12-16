(** Identity function. *)
val id : 'a -> 'a

(** Function composition. (f >> g) x represents g (f x). *)
val ( >> ) : ('a -> 'b) -> ('b -> 'c) -> 'a -> 'c

(** Function composition. (f << g) x represents f (g x). *)
val ( << ) : ('a -> 'b) -> ('c -> 'a) -> 'c -> 'b