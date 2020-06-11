divider(-).
addClassToPos(pos(I,J), Class):-
  divider(X),
  atomic_list_concat([X,I,X,J], Atom),
  atom_concat(cell, Atom, Id),
  get_by_id(Id, Cell),
  add_class(Cell, Class).

removeClassToPos(pos(I,J), Class):-
  divider(X),
  atomic_list_concat([X,I,X,J], Atom),
  atom_concat(cell, Atom, Id),
  get_by_id(Id, Cell),
  remove_class(Cell, Class).

visualizeSolution(List):-
  start(S),
  visualizeSolution(S,List).

visualizeSolution(S,[]):-
  addClassToPos(S, solution).

visualizeSolution(S,[H|T]):-
  write(S),
  addClassToPos(S, solution),
  transform(H,S,Pos),
  visualizeSolution(Pos,T).