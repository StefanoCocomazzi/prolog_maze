dfs(Solution):-
  start(S),
  search_dfs(S,[S],Solution).

search_dfs(S,_,[]):-
  goal(S),!.

search_dfs(S, Visited,[Action| PathToGoal]):-

  applicable(Action, S),
  transform(Action, S, S1),
  \+member(S1, Visited),
  search_dfs(S1,[S1|Visited],PathToGoal).
