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


% Bound := f(StartNode);
% Repeat
% dfs(Start, Bound)
%   if (Solution)
%      retutn Solution;
%   Bound := min(leafs)

:-dynamic(bound/1).
:-dynamic(minBound/1).
assert(bound(1)).
updateBound(Bound):-
  retractall(bound(_)),
  assert(bound(Bound)).

updateMinBound(FValue):-
  write(FValue),
  minBound(M),
  FValue<M,
  retractall(minBound(_)),
  assert(minBound(FValue)).
updateMinBound(_):-true.


%============================================================
idastar(Solution):-
  start(S),
  computeHeuristic(S,H),
  assert(bound(H)),
  aux(node(S,0),[],Solution).

aux(N,L,S):-
  dfs(N,L,S),!.


aux(N,L,S):-
  minBound(M),
  updateBound(M),
  dfs(N,L,S).



dfs(S,_,[]):-
    goal(S),!.

dfs(node(S, Depth), Visitati, [Az|Sequenza] ):-
    applicable(Az, S),
    transform(Az, S, F),
    \+member(F,Visitati),
    NewDep is Depth+1,
    NewNode = node(F,NewDep),
    chechBound(NewNode),
    dfs(NewNode, [F|Visitati],Sequenza).

chechBound(node(Pos,Depth)):-
    bound(Bound),
    computeHeuristic(Pos,H),
    FValue is H+Depth,
    Bound<FValue,
    updateMinBound(FValue),
    false.


    % addClassToPos(S, current),
    % % travel_speed(Spd),
    % % sleep(Spd),
    % removeClassToPos(S, current),
    % addClassToPos(F, visited),