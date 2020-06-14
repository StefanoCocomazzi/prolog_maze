%%% Iterative deepening Depth Firs Search %%%
iddfs(Soluzione) :-
    start(S),
%    max_bound(Limite),
    iddfs(S, 1, 10, Soluzione).

iddfs(_, I, Limite, _) :-
    I > Limite, !.

iddfs(S, I,_ , Soluzione) :-
    ricerca_profondita_limitata(S, [], I, Soluzione), !.

iddfs(S, I, Limite, Soluzione) :-
    removeAllClass(current),
    removeAllClass(visited),
    NI is I + 1,
    iddfs(S, NI, Limite, Soluzione).

ricerca_profondita_limitata(S,_,_,[]):-
    goal(S),!.

ricerca_profondita_limitata(S,Visitati,Limite,[Az|SequenzaAzioni]):-
    addClassToPos(S,current),
    travel_speed(Spd),
    sleep(Spd),
    replaceClassToPos(S,current,visited),
    Limite>0,
    applicable(Az,S),
    transform(Az,S,NuovoStato),
    \+member(NuovoStato,Visitati),
    NuovoLimite is Limite - 1,
    ricerca_profondita_limitata(NuovoStato, [S|Visitati], NuovoLimite, SequenzaAzioni).

