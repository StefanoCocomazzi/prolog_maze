% ==================================================================
computeHeuristic(pos(X,Y), Res):-
    goal(pos(X1,Y1)),
    Res is abs(X - X1) + abs(Y - Y1).

astar(X):-
    start(S),
    a_star( [node(S, 0, 0, [])],Soluzione),
    inverti(Soluzione, X).


a_star([],_):- fail.

a_star([node(N,_,_,PathToNode)|_], PathToNode):-
  goal(N),!.

a_star([Node|Open],Sol):-
% 2- Let n be the first node on open. Remove n from open. Fail if open is empty.
  expand(Node, Children), % compute f cost forEach
  insertChildren(Children,Open,NewOpenList),
  a_star(NewOpenList,Sol).

expand(node(Pos,X,Y,Z), Neighbors):-
  findall(Act, applicable(Act, Pos), Actions),
  getNeighbors(node(Pos,X,Y,Z), Actions, Neighbors).

insertChildren([],Open,Open).
insertChildren([C|Children],Open,NewOpenList):-
  \+memberNode(C,Open),!,
  insert(C, Open,NewOpen),
  insertChildren(Children, NewOpen, NewOpenList).
insertChildren([_|Children],Open,NewOpenList):-
% todo -> check when new value is better than previous
  insertChildren(Children, Open, NewOpenList).


insert(Node, [], [Node]):- !.
insert(Node, [H|Open], [Node, H|Open]):-
  compare_gteq(Node,H), !.
insert(Node, [H|Open], [H|L]):-
  insert(Node, Open, L).

compare_gteq(node(_,_,F1,_),node(_,_,F2,_)):-
  C is F2-F1,C>=0.


memberNode(node(X,_,_,_), [node(Y,_,_,_)|T]):-
  X = Y; memberNode(node(X,_,_,_), T).


% getNeighbors/2
getNeighbors(_, [], []).
getNeighbors(node(Pos, Depth, FValue, PathToNode), [Act|Actions], [NewNode| Neighbors]):-
  transform(Act,Pos,NewPos),
  NewDepth is Depth + 1,
  computeHeuristic(NewPos, HValue),
  NewFValue is HValue + Depth,
  NewNode = node(NewPos, NewDepth, NewFValue,[Act|PathToNode]),
  getNeighbors(node(Pos, Depth, FValue, PathToNode),Actions,Neighbors).



