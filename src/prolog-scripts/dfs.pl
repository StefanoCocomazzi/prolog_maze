:- use_module(library(dom)).
:- use_module(library(system)).

dfs(Solution):-
  start(S),
  search_dfs(S,[S],Solution).

search_dfs(S,_,[]):-
  goal(S),!.

% search_dfs(S, Visited,[Action| PathToGoal]):-
%   applicable(Action, S),
%   transform(Action, S, S1),
%   \+member(S1, Visited),
%   X =.. S,
%   write(X),
%   search_dfs(S1,[S1|Visited],PathToGoal).


search_dfs(pos(I,J), Visited,[Action| PathToGoal]):-
  applicable(Action, pos(I,J)),
  transform(Action, pos(I,J), S1),
  \+member(S1, Visited),
	number_chars(I, [AtomRow]),
	number_chars(J, [AtomCol]),
	atom_concat(cell, AtomRow, ColRow),
	atom_concat(ColRow, AtomCol, Id),
  get_by_id(Id, Cell),
  % Sleep is 0.,
  sleep(100),
  search_dfs(S1,[S1|Visited],PathToGoal).