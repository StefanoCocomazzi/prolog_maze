columns(10).
rows(10).
start(pos(6,3)).
goal(pos(4,7)).
wall(pos(2,7)).
wall(pos(2,8)).
wall(pos(3,6)).
wall(pos(3,7)).
wall(pos(4,5)).
wall(pos(4,6)).
wall(pos(5,5)).
wall(pos(6,4)).
wall(pos(6,5)).
wall(pos(7,3)).
wall(pos(7,4)).
wall(pos(8,2)).
wall(pos(8,3)).
wall(pos(9,1)).
wall(pos(9,2)).
wall(pos(10,1)).
wall(_):- false.

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



bfs(Soluzione):-
    start(S),
    write(S),
    ricercaAmpiezza([nodo(S,[])],[],Soluzione).

ricercaAmpiezza([nodo(S,AzioniPerS)|_],_, AzioniPerS):-
    goal(S),!.

ricercaAmpiezza([nodo(S,AzioniPerS)|CodaStati], Visitati, Soluzione):-
    write(S),
    findall(Az, applicable(Az, S), ListaAzApplicabili),
    generaStatiFigli(nodo(S,AzioniPerS), [S|Visitati], ListaAzApplicabili, StatiFigli),
    append(CodaStati,StatiFigli,NuovaCoda),
    ricercaAmpiezza(NuovaCoda,[S|Visitati], Soluzione).



generaStatiFigli(_,_,[],[]).
generaStatiFigli(nodo(S,AzioniPerS), Visitati, [Az|AltreAzioni],[nodo(SNuovo, [Az|AzioniPerS])|AltriFigli]):-
    transform(Az,S,SNuovo),
    \+member(SNuovo, Visitati),!,
    % addClassToPos(SNuovo,visited),
    generaStatiFigli(nodo(S,AzioniPerS), Visitati, AltreAzioni, AltriFigli).
generaStatiFigli(nodo(S,AzioniPerS), Visitati, [_|AltreAzioni], AltriFigli):-
    generaStatiFigli(nodo(S,AzioniPerS), Visitati, AltreAzioni, AltriFigli).
