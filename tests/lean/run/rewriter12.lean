import data.nat
open nat
constant f : nat → nat

example (x y : nat) (H1 : (λ z, z + 0) x = y) : f x = f y :=
by rewrite [▸* at H1, ^[add, nat.rec_on, of_num] at H1, H1]

example (x y : nat) (H1 : (λ z, z + 0) x = y) : f x = f y :=
by rewrite [▸* at H1, ↑[add, nat.rec_on, of_num] at H1, H1]
