(**
   lexer.mll - Copyright (c) 2018 TheAspiringHacker
   This file is licensed under the Expat license; see LICENSE for details.
 *)

{
open Parser
}

let sign = ['-' '+']
let digit = ['0'-'9']
let frac = '.' digit*
let exp = ['e' 'E'] sign? digit*
let float1 = sign? digit* frac exp?
let float2 = sign? digit+ frac? exp?
let whitespace = [' ' '\t']

rule lex = parse
| '\n' { Lexing.new_line lexbuf; lex lexbuf }
| whitespace { lex lexbuf }
| float1 as str { NUMBER (float_of_string str) }
| float2 as str { NUMBER (float_of_string str) }
| '(' { LPARENS }
| ')' { RPARENS }
| '+' { PLUS }
| '-' { MINUS }
| '*' { STAR }
| '/' { SLASH }
| '^' { CARET }
| eof { EOF }

{
}
