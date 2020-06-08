columns(10).
rows(10).
start(pos(6,8)).
goal(pos(7,5)).
wall(pos(1,2)).
wall(pos(1,4)).
wall(pos(1,7)).
wall(pos(3,3)).
wall(pos(3,4)).
wall(pos(3,5)).
wall(pos(3,6)).
wall(pos(3,9)).
wall(pos(4,5)).
wall(pos(5,3)).
wall(pos(7,1)).
wall(pos(8,2)).
wall(pos(8,4)).
wall(pos(8,6)).
wall(pos(8,9)).
wall(pos(9,3)).
wall(pos(9,5)).
wall(pos(9,7)).
wall(pos(9,9)).
wall(pos(10,9)).
wall(_):- false.


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

% ==================================================================

computeHeuristic(pos(X,Y), Res):-
    goal(pos(X1,Y1)),
    Res is abs(X - X1) + abs(Y - Y1).


% 1- Start with the start node, place it in the (previously empty) list open.
% 2- Let n be the first node on open. Remove n from open. Fail if open is empty.
% 3- If n is the goal, then a solution has been found. (One could stop here.)
% 4- Expand n, obtaining all of its children, and evaluate f(-) for each of them.
%     Insert each of these children into open, maintaining order [smallest f(-)  first]
% 5- Repeat from step 2.

% Node structure is as follows:
  % node(Pos, Depth, FValue, PathToNode )
a_star(Solution):-
  start(S),
  OpenList = [node(S, 0, 0, [])],
  a_star(OpenList, Solution).

a_star([],_):- fail.

a_star([node(N,_,_,PathToNode)|_], PathToNode):-
  goal(N),!.

a_star([Node|Open],Sol):-
% 2- Let n be the first node on open. Remove n from open. Fail if open is empty.
  expand(Node, Children), % compute f cost forEach
  insertChildren(Children,Open,NewOpenList),
  a_star(NewOpenList,Sol).

expand(node(Pos,X,Y,Z), Neighbors):-
  findall(Act, applicable(Act, Pos), Actions),
  getNeighbors(node(Pos,X,Y,Z), Actions, Neighbors).

insertChildren([],Open,Open).
insertChildren([C|Children],Open,NewOpenList):-
  \+memberNode(C,Open),!,
  insert(C, Open,NewOpen),
  insertChildren(Children, NewOpen, NewOpenList).
insertChildren([_|Children],Open,NewOpenList):-
% todo -> check when new value is better than previous
  insertChildren(Children, Open, NewOpenList).


insert(Node, [], [Node]):- !.
insert(Node, [H|Open], [Node, H|Open]):-
  compare_gteq(Node,H), !.
insert(Node, [H|Open], [H|L]):-
  insert(Node, Open, L).

compare_gteq(node(_,_,F1,_),node(_,_,F2,_)):-
  C is F2-F1,C>=0.


memberNode(node(X,_,_,_), [node(Y,_,_,_)|T]):-
  X = Y; memberNode(node(X,_,_,_), T).

% getNeighbors/2

getNeighbors(_, [], []).


getNeighbors(node(Pos, Depth, FValue, PathToNode), [Act|Actions], [NewNode| Neighbors]):-
  transform(Act,Pos,NewPos),
  NewDepth is Depth + 1,
  computeHeuristic(NewPos, HValue),
  NewFValue is HValue + Depth,
  NewNode = node(NewPos, NewDepth, NewFValue,[Act|PathToNode]),
  getNeighbors(node(Pos, Depth, FValue, PathToNode),Actions,Neighbors).



