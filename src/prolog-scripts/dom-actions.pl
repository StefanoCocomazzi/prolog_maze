divider(-).
addClassToNode4(node(Pos,_,_,_), Class):-
  addClassToPos(Pos, Class).
addClassToPos(pos(I,J), Class):-
  divider(X),
  atomic_list_concat([X,I,X,J], Atom),
  atom_concat(cell, Atom, Id),
  get_by_id(Id, Cell),
  add_class(Cell, Class).

removeClassToNode4(node(Pos,_,_,_), Class):-
  removeClassToPos(Pos, Class).
removeClassToPos(pos(I,J), Class):-
  divider(X),
  atomic_list_concat([X,I,X,J], Atom),
  atom_concat(cell, Atom, Id),
  get_by_id(Id, Cell),
  remove_class(Cell, Class).



replaceClassToNode4(node(Pos,_,_,_), ToRemove, ToAdd):-
  replaceClassToPos(Pos, ToRemove, ToAdd).

replaceClassToPos(pos(I,J), ToRemove, ToAdd):-
  divider(X),
  atomic_list_concat([X,I,X,J], Atom),
  atom_concat(cell, Atom, Id),
  get_by_id(Id, Cell),
  remove_class(Cell, ToRemove),
  add_class(Cell, ToAdd).

removeAllClass(Class):-
  findall(HTMLObj,get_by_class(Class, HTMLObj), Bag),
  aux_remove_all(Bag,Class).

aux_remove_all([],_).
aux_remove_all([Cell|T],Class):-
  remove_class(Cell, Class),
  aux_remove_all(T,Class).

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