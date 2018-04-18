(**
   main.ml - Copyright (c) 2018 TheAspiringHacker
   This file is licensed under the Expat license; see LICENSE for details.
 *)

let rec read_eval_print () =
  try
    Lexing.from_channel stdin
    |> Parser.entry Lexer.lex
    |> Ast.eval
    |> string_of_float
    |> print_endline; 0
  with
  | Failure what -> prerr_endline what; 1
  | Parser.Error -> prerr_endline "Parse error"; 2

let () = exit @@ read_eval_print ()
