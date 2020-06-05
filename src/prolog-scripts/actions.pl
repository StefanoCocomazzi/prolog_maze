%applicable(east, pos(Row, Col)):-
%    columns(Num),
%    Col < Num,
%    NextCol is Col + 1,
%    \+wall(pos(Row, NextCol)).
%
%
%applicable(west ,pos(Row,Col)):-
%    Col > 1,
%    NextCol is Col - 1,
%    \+wall(pos(Row, NextCol)).
%
%applicable(south ,pos(Row,Col)):-
%    rows(Num),
%    Row < Num,
%    NextRow is Row + 1,
%    \+wall(pos(NextRow, Col)).
%
%applicable(north ,pos(Row,Col)):-
%    Row > 1,
%    NextRow is Row - 1,
%    \+wall(pos(NextRow, Col)).
%
%transform(east,pos(Row,Col), pos(Row, NextCol)):- NextCol is Col + 1.
%transform(west,pos(Row,Col), pos(Row, NextCol)):- NextCol is Col - 1.
%transform(north,pos(Row,Col), pos(NextRow, Col)):- NextRow is Row - 1.
%transform(south,pos(Row,Col), pos(NextRow, Col)):- NextRow is Row + 1.

:- use_module(library(lists)).

applicable(east, pos(Row,Col)):-
  columns(NUM_COLS),
  Col < NUM_COLS,
  EAST is Col+1,
  \+wall(pos(Row,EAST)).

applicable(west, pos(Row,Col)):-
  Col > 1,
  WEST is Col-1,
  \+wall(pos(Row,WEST)).

applicable(north, pos(Row,Col)):-
  Row > 1,
  NORTH is Row-1,
  \+wall(pos(NORTH,Col)).

applicable(south, pos(Row,Col)):-
  rows(NUM_ROWS),
  Row < NUM_ROWS,
  SOUTH is Row+1,
  \+wall(pos(SOUTH,Col)).


transform(east, pos(Row, Col), pos(Row, EAST)):- EAST is Col+1.
transform(west, pos(Row, Col), pos(Row, WEST)):- WEST is Col-1.
transform(north, pos(Row, Col), pos(NORTH, Col)):- NORTH is Row-1.
transform(south, pos(Row, Col), pos(SOUTH, Col)):- SOUTH is Row+1.