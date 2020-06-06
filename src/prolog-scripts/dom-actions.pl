:- use_module(library(dom)).

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

visualizeSolution(List):-
  start(S),
  visualizeSolution(S,List).

visualizeSolution(S,[]):-
  addClassToPos(S, solution).

visualizeSolution(S,[H|T]):-
  addClassToPos(S, solution),
  transform(H,S,Pos),
  visualizeSolution(Pos,T).