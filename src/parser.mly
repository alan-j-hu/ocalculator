(**
   parser.mly - Copyright (c) 2018 TheAspiringHacker
   This file is licensed under the Expat license; see LICENSE for details.
 *)

%token <float> NUMBER
%token PLUS MINUS
%token STAR SLASH
%token LPARENS RPARENS
%token CARET
%token EOF

%start <(Lexing.position * Lexing.position) Ast.expr> entry

%%

entry: term EOF {$1}

term:
  | term PLUS factor {
    Ast.{annot = ($symbolstartpos, $endpos); node = Ast.Add($1, $3)}
  }
  | term MINUS factor {
    Ast.{annot = ($symbolstartpos, $endpos); node = Ast.Sub($1, $3)}
  }
  | factor {
    $1
  }

factor:
  | factor STAR expo {
    Ast.{annot = ($symbolstartpos, $endpos); node = Ast.Mul($1, $3)}
  }
  | factor SLASH expo {
    Ast.{annot = ($symbolstartpos, $endpos); node = Ast.Div($1, $3)}
  }
  | expo {
    $1
  }

expo:
  | NUMBER CARET expo {
    Ast.{
      annot = ($symbolstartpos, $endpos);
      node = Ast.Exp(Ast.{
        annot = ($symbolstartpos, $endpos);
        node = Ast.Num $1
      }, $3)
    }
  }
  | NUMBER {
    Ast.{annot = ($symbolstartpos, $endpos); node = Ast.Num $1}
  }
  | LPARENS term RPARENS {
    $2
  }
