columns(10).
rows(10).
start(pos(6,8)).
goal(pos(7,5)).
wall(pos(1,2)).
wall(pos(1,4)).
wall(pos(1,7)).
wall(pos(3,3)).
wall(pos(3,4)).
wall(pos(3,5)).
wall(pos(3,6)).
wall(pos(3,9)).
wall(pos(4,5)).
wall(pos(5,3)).
wall(pos(7,1)).
wall(pos(8,2)).
wall(pos(8,4)).
wall(pos(8,6)).
wall(pos(8,9)).
wall(pos(9,3)).
wall(pos(9,5)).
wall(pos(9,7)).
wall(pos(9,9)).
wall(pos(10,9)).
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

% ==================================================================

computeHeuristic(pos(X,Y), Res):-
    goal(pos(X1,Y1)),
    Res is abs(X - X1) + abs(Y - Y1).


%  path              current search path (acts like a stack)
%  node              current node (last node in current path)
%  g                 the cost to reach current node
%  f                 estimated cost of the cheapest path (root..node..goal)
%  h(node)           estimated cost of the cheapest path (node..goal)
%  cost(node, succ)  step cost function
%  is_goal(node)     goal test
%  successors(node)  node expanding function, expand nodes ordered by g + h(node)
%  ida_star(root)    return either NOT_FOUND or a pair with the best path and its cost

%  procedure ida_star(root)
%    bound := h(root)
%    path := [root]
%    loop
%      t := search(path, 0, bound)
%      if t = FOUND then return (path, bound)
%      if t = ∞ then return NOT_FOUND
%      bound := t
%    end loop
%  end procedure

:-dynamic(bound/1).
assert(bound(9999)).
updateBound(Bound):-
  retractall(bound(_)),
  assert(bound(Bound)).


idastar(Solution):-
  computeHeuristic(S,H),
  updateBound(H),
  start(S),
  search([node(S,0,[])],Solution).


% node(Pos,Depth,PathToPos)
% ida_star(Path,Solution)
search([node(Pos, _, PathToPos)|_],PathToPos):-
  goal(Pos),!.
search([node(Pos,Depth,PathToPos)|Path],Solution):-
  computeHeuristic(Pos, H):-
  F is Depth + H,
  bound(Bound),
  F > Bound,
  !,
  updateBound(F),
  search([node(Pos, _, PathToPos)|Path],Solution).


search([node(Pos,Depth,PathToPos)|Path],Solution):-
  computeHeuristic(Pos, H):-
  expand(node(Pos,Depth,PathToPos), Path, Solution).


expand(node(Pos,Depth, PathToPos), Solution):-
  findall(Act, applicable(Act,Pos), Actions),
  getNeighbors(node(Pos,Depth, PathToPos), Actions, Solution).


getNeighbors(_, [], []).
getNeighbors(node(Pos,Depth, PathToPos), [Act| Actions], [NewNode| Neighbors]):-
    transform(Act, Pos, NewPos),
    NewDep is Depth+1,
    NewNode = node(NewPos, NewDep,[Act|PathToPos]),
    search()
    % getNeighbors(node(Pos,Depth, PathToPos),Actions,Neighbors).


%  function search(path, g, bound)
%    node := path.last
%    f := g + h(node)
%    if f > bound then return f
%    if is_goal(node) then return FOUND
%    min := ∞
%    for succ in successors(node) do
%      if succ not in path then
%        path.push(succ)
%        t := search(path, g + cost(node, succ), bound)
%        if t = FOUND then return FOUND
%        if t < min then min := t
%        path.pop()
%      end if
%    end for
%    return min
%  end function




