%%% Depth First Search a profondità Limitata %%%

dfs_limitata(Soluzione,Limite):-
    iniziale(S),
    ricerca_profondita_limitata(S,[], Limite, Soluzione).

ricerca_profondita_limitata(S,_,_,[]):- finale(S),!.

ricerca_profondita_limitata(S,Visitati,Limite,[Az|SequenzaAzioni]):-
    Limite>0,
    applicabile(Az,S),
    trasforma(Az,S,NuovoStato),
    \+member(NuovoStato,Visitati),
    NuovoLimite is Limite - 1,
    ricerca_profondita_limitata(NuovoStato, [S|Visitati], NuovoLimite, SequenzaAzioni).
