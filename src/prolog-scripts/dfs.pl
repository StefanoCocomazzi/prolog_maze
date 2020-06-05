:- use_module(library(dom)).
:- use_module(library(system)).

dfs(Soluzione):-
    start(S),
    ricerca_depth(S,[S],Soluzione).

ricerca_depth(S,_,[]):-
    goal(S),!.

ricerca_depth(S, Visitati, [Az|Sequenza] ):-
    addClassToPos(S, current),
    write(S),
    removeClassToPos(S, current),
    applicable(Az, S),
    transform(Az, S, F),
    \+member(F,Visitati),
    addClassToPos(F, visited),
    ricerca_depth(F, [F|Visitati],Sequenza).


addClassToPos(pos(I,J), Class):-
  atomic_list_concat([I,J], Atom),
  atom_concat(cell, Atom, Id),
  get_by_id(Id, Cell),
  add_class(Cell, Class).

removeClassToPos(pos(I,J), Class):-
  atomic_list_concat([I,J], Atom),
  atom_concat(cell, Atom, Id),
  get_by_id(Id, Cell),
  remove_class(Cell, Class).