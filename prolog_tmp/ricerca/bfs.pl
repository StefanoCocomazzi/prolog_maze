bfs(Soluzione):-
    iniziale(S),
    ricercaAmpiezza([nodo(S,[])],[],Soluzione).

ricercaAmpiezza([nodo(S,AzioniPerS)|_],_, AzioniPerS):-
    finale(S),!.

ricercaAmpiezza([nodo(S,AzioniPerS)|CodaStati], Visitati, Soluzione):-
    findall(Az, applicabile(Az, S), ListaAzApplicabili),
    generaStatiFigli(nodo(S,AzioniPerS), [S|Visitati], ListaAzApplicabili, StatiFigli),
    append(CodaStati,StatiFigli,NuovaCoda),
    ricercaAmpiezza(NuovaCoda,[S|Visitati], Soluzione).



generaStatiFigli(_,_,[],[]).
generaStatiFigli(nodo(S,AzioniPerS), Visitati, [Az|AltreAzioni],[nodo(SNuovo, [Az|AzioniPerS])|AltriFigli]):-
    trasforma(Az,S,SNuovo),
    \+member(SNuovo, Visitati),!,
    generaStatiFigli(nodo(S,AzioniPerS), Visitati, AltreAzioni, AltriFigli).
generaStatiFigli(nodo(S,AzioniPerS), Visitati, [_|AltreAzioni], AltriFigli):-
    generaStatiFigli(nodo(S,AzioniPerS), Visitati, AltreAzioni, AltriFigli).

