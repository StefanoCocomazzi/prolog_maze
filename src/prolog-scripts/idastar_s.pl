columns(5).
rows(5).
start(pos(1,5)).
goal(pos(5,1)).
wall(_):- false.

max_bound(26).

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

:-dynamic(bound/1).
assert(max_bound(0)).
set_bound(Bound):-
    retractall(bound(_)),
    asserta(bound(Bound)).

update_bound(NewBound):-
    bound(Bound),
    NewBound >= Bound, !.

update_bound(NewBound):-
    set_bound(NewBound).



% h(Position, Result) calcola la distanza di manhattan tra Position e il goal.
h(pos(X,Y), H):-
    goal(pos(X1,Y1)),
    H is abs(X - X1) + abs(Y - Y1).

f(Pos, G, F):-
    h(Pos, H),
    F is G + H.

idastar(Solution) :-
    start(S),
    h(S,H),
    set_bound(H),
    perform_idastar(S,0,Solution).


% perform_idastar(Position, Cost, Bound, Solution)

perform_idastar(Position, G, Solution):-
    bound(Bound),
    format('~w ~n', [Bound]),
    max_bound(Max),
    set_bound(Max),
    dfs_informata(Position, G, Bound, [], Solution).

perform_idastar(_, _, Solution):-
    start(S),
    bound(Bound),
    max_bound(MaxBound),
    Bound < MaxBound,
    perform_idastar(S, 0, Solution).

% caso base
dfs_informata(S,_,_,_,[]):-
    goal(S),!.

dfs_informata(Position, G, Bound, Visited, [Az|Sequenza] ):-
    f(Position, G, F),
    F =< Bound,
    applicable(Az, Position),
    transform(Az, Position, NewPosition),
    \+member(NewPosition,Visited),
    NewG is G + 1,
    dfs_informata(NewPosition, NewG , Bound, [NewPosition|Visited], Sequenza).

dfs_informata(Position, G, Bound, _, _):-
    f(Position, G, F),
    F > Bound,
    update_bound(F),
    fail.





