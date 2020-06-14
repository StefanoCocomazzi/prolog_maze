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
    max_bound(Max),
    set_bound(Max),
    dfs_informata(Position, G, Bound, [], Solution).

perform_idastar(_, _, Solution):-
    start(S),
    bound(Bound),
    max_bound(MaxBound),
    Bound < MaxBound,
    removeAllClass(visited),
    perform_idastar(S, 0, Solution).

% caso base
dfs_informata(S,_,_,_,[]):-
    goal(S),!.

dfs_informata(Position, G, Bound, Visited, [Az|Sequenza] ):-
    addClassToPos(Position, current),
    travel_speed(Spd),
    sleep(Spd),
    replaceClassToPos(Position, current, visited),
    f(Position, G, F),
    F =< Bound,
    applicable(Az, Position),
    transform(Az, Position, NewPosition),
    \+member(NewPosition,Visited),
    NewG is G + 1,
    dfs_informata(NewPosition, NewG , Bound, [NewPosition|Visited], Sequenza).

dfs_informata(Position, G, Bound, _, _):-
    f(Position, G, F),
    update_bound(F),
    fail.