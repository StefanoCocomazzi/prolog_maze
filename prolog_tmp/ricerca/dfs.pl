%%% Depth First Search %%%.

dfs(Soluzione):-
    iniziale(S),
    ricerca_depth(S,[S],Soluzione).

ricerca_depth(S,_,[]):-
    finale(S),!.

ricerca_depth(S, Visitati, [Az|Sequenza] ):-
    applicabile(Az, S),
    trasforma(Az, S, F),
    \+member(F,Visitati),
    ricerca_depth(F, [F|Visitati],Sequenza).

