:- use_module(library(system)).

dfs(Soluzione):-
    start(S),
    ricerca_depth(S,[S],Soluzione).

ricerca_depth(S,_,[]):-
    goal(S),!.

ricerca_depth(S, Visitati, [Az|Sequenza] ):-
    addClassToPos(S, current),
    sleep(300),
    removeClassToPos(S, current),
    applicable(Az, S),
    transform(Az, S, F),
    \+member(F,Visitati),
    addClassToPos(F, visited),
    ricerca_depth(F, [F|Visitati],Sequenza).


