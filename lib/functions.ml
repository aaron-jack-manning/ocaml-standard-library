let id (x : 'a) = x

let ( >> ) f g x = g (f x)

let ( << ) g f x = g (f x)