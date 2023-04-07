#!/usr/bin/env jq -jf

{
  eof: "",
  l_paren: "(",
  r_paren: ")",
  l_brace: "{",
  r_brace: "}",
  l_square: "[",
  r_square: "]",
  l_angle: "<",
  r_angle: ">",
  period: ".",
  period_prefix: ".",
  comma: ",",
  ellipsis: "...",
  colon: ":",
  semi: ";",
  equal: "=",
  at_sign: "@",
  pound: "#",
  amp_prefix: "&",
  arrow: "->",
  backtick: "`",
  backslash: "\\",
  exclaim_postfix: "!",
  question_postfix: "?",
  question_infix: "?",
  string_quote: "\"",
  single_quote: "'",
  multiline_string_quote: "\"\"\"",
  string_interpolation_anchor: ")",
} as $token_text |

def ltrim($str):
  if startswith($str) then ltrimstr($str) else empty end;

def token_text:
  .leadingTrivia,
  (.tokenKind | .text // (.kind | $token_text[.] // ltrim("kw_") // "#" + ltrim("pound_")) // error),
  .trailingTrivia;

def tokens:
  if .layout then
    .layout[] | values | tokens
  else
    .
  end;

[tokens | token_text] | add
