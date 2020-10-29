#!/usr/bin/env jq -jf

import "trivia_text" as $trivia_text {search: "./"};
import "token_text" as $token_text {search: "./"};

def trivia_text:
  (.value | strings) //
  (reduce range(.value - 1) as $_ ([$trivia_text[][.kind] // error]; . + .[:1]) | add);

def token_text:
  (.leadingTrivia[] | trivia_text),
  (.tokenKind | .text // $token_text[][.kind]) // error,
  (.trailingTrivia[] | trivia_text);

def tokens:
  if .layout then
    .layout[] | values | tokens
  else
    .
  end;

[tokens | token_text] | add
