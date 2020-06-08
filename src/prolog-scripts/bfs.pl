
bfs(X):-
    start(S),
    ricercaAmpiezza([nodo(S,[])],[],Soluzione),
    inverti(Soluzione, X).

ricercaAmpiezza([nodo(S,AzioniPerS)|_],_, AzioniPerS):-
    goal(S),!.

ricercaAmpiezza([nodo(S,AzioniPerS)|CodaStati], Visitati, Soluzione):-
    addClassToPos(S,current),
    % sleep(50),
    % travel_speed(Spd),
    % sleep(Spd),
    findall(Az, applicable(Az, S), ListaAzApplicabili),
    generaStatiFigli(nodo(S,AzioniPerS), [S|Visitati], ListaAzApplicabili, StatiFigli),
    append(CodaStati,StatiFigli,NuovaCoda),
    ricercaAmpiezza(NuovaCoda,[S|Visitati], Soluzione).



generaStatiFigli(_,_,[],[]).
generaStatiFigli(nodo(S,AzioniPerS), Visitati, [Az|AltreAzioni],[nodo(SNuovo, [Az|AzioniPerS])|AltriFigli]):-
    transform(Az,S,SNuovo),
    \+member(SNuovo, Visitati),!,
    addClassToPos(SNuovo,visited),
    generaStatiFigli(nodo(S,AzioniPerS), Visitati, AltreAzioni, AltriFigli).
generaStatiFigli(nodo(S,AzioniPerS), Visitati, [_|AltreAzioni], AltriFigli):-
    generaStatiFigli(nodo(S,AzioniPerS), Visitati, AltreAzioni, AltriFigli).

