%%% Iterative deepening Depth Firs Search %%%

iterative_deepening(Limite, Soluzione) :-
    iniziale(S),
    iddfs(S, 1, Limite, Soluzione).

iddfs(_, I, Limite, _) :-
    I > Limite, !.

iddfs(S, I,_ , Soluzione) :-
    ricerca_profondita_limitata(S, [], I, Soluzione), !.

iddfs(S, I, Limite, Soluzione) :-
    NI is I + 1,
    iddfs(S, NI, Limite, Soluzione).

ricerca_profondita_limitata(S,_,_,[]):- finale(S),!.

ricerca_profondita_limitata(S,Visitati,Limite,[Az|SequenzaAzioni]):-
    Limite>0,
    applicabile(Az,S),
    trasforma(Az,S,NuovoStato),
    \+member(NuovoStato,Visitati),
    NuovoLimite is Limite - 1,
    ricerca_profondita_limitata(NuovoStato, [S|Visitati], NuovoLimite, SequenzaAzioni).