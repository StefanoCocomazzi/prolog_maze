
bfs(X):-
    start(S),
    ricercaAmpiezza([nodo(S,[])],[],Soluzione),
    inverti(Soluzione, X).

ricercaAmpiezza([nodo(S,AzioniPerS)|_],_, AzioniPerS):-
    goal(S),!.

ricercaAmpiezza([nodo(S,AzioniPerS)|CodaStati], Visitati, Soluzione):-
    removeClassToPos(S,expanded),
    addClassToPos(S,current),
    % sleep(50),
    addClassToPos(S,visited),
    findall(Az, applicable(Az, S), ListaAzApplicabili),
    generaStatiFigli(nodo(S,AzioniPerS), [S|Visitati], ListaAzApplicabili, StatiFigli),
    travel_speed(Spd),
    sleep(Spd),
    removeClassToPos(S,current),
    unione(CodaStati,StatiFigli,NuovaCoda),
    ricercaAmpiezza(NuovaCoda,[S|Visitati], Soluzione).



generaStatiFigli(_,_,[],[]).
generaStatiFigli(nodo(S,AzioniPerS), Visitati, [Az|AltreAzioni],[nodo(SNuovo, [Az|AzioniPerS])|AltriFigli]):-
    transform(Az,S,SNuovo),
    % write(member(SNuovo, Visitati)),
    \+member(SNuovo, Visitati),!,
    % write(SNuovo),
    addClassToPos(SNuovo,expanded),
    generaStatiFigli(nodo(S,AzioniPerS), Visitati, AltreAzioni, AltriFigli).
generaStatiFigli(nodo(S,AzioniPerS), Visitati, [_|AltreAzioni], AltriFigli):-
    generaStatiFigli(nodo(S,AzioniPerS), Visitati, AltreAzioni, AltriFigli).

memberNode(nodo(X,_), [nodo(Y,_)|T]):-
  X = Y; memberNode(nodo(X,_), T).
unione([],B,B).
unione([Head|Tail], B, Unione):-
    memberNode(Head, B),
    !,
    unione(Tail,B,Unione).
unione([Head|Tail],B, [Head|Unione]):-
    unione(Tail, B, Unione).