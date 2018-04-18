(**
   ast.ml - Copyright (c) 2018 TheAspiringHacker
   This file is licensed under the Expat license; see LICENSE for details.
 *)

type 'a expr = {
    annot : 'a;
    node : 'a expr'
  }

and 'a expr' =
  | Add of 'a expr * 'a expr
  | Sub of 'a expr * 'a expr
  | Mul of 'a expr * 'a expr
  | Div of 'a expr * 'a expr
  | Exp of 'a expr * 'a expr
  | Num of float

let rec eval {annot; node} =
  match node with
  | Add(x, y) -> eval x +. eval y
  | Sub(x, y) -> eval x -. eval y
  | Mul(x, y) -> eval x *. eval y
  | Div(x, y) -> eval x /. eval y
  | Exp(x, y) -> eval x ** eval y
  | Num n -> n
