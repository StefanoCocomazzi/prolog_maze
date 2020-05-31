

% expand(P, Tree, Bound, Tree1, Solved, Solution).
% P = Cammino tra Start e Tree.
% Tree = Sottoalbero corrente
% Bound = F limite per l'espansione di Tree
% Tree1 = Tree espanso all'interno del Bound. Conseguentemente il valore F di tree1 è maggiore del Bound (se il goal non è ancora stato raggiunto).
% Solved = Yes / No / Never Indicano se il goal è stato raggiunto durante l'espansione di Tree
% Solution è il cammino dal nodo di start fino al nodo Goal (se esiste).

% INPUTS : P, Tree, Bound
% OUTPUTS: Solved, Soluzion, Tree1.

% Rappresenzazione alberi: 
%Tree: t(N, F/G, [T|Ts]).
%Leaf: l(N, F/G).

% N è il nodo corrente
% G il costo del cammino da start ad N, F è il valore di F del sottoalbero più promettente, [T|Ts] è la lista dei nodi figli.

bestfirst(Solution) :-
    start(Start),
    expand([], l(Start, 0/0), 9999,_, yes, Solution).

% Caso 1. nodo foglia in cui c'è il goal

expand(P, l(N,_),_,_,yes,[N|P]):-
    goal(N).

% Caso 2. nodo foglia con f-value minore del boung. 

expand(P,l(N,F/G), Bound, Tree1, Solved, Solution):-
    F =< Bound,
    ( 
        bagof(M/C, (s(N,M,C), \+ member(M,P),), Succ), % 
        !,
        succlist(G,Succ,Ts),
        bestf(Ts,F1),
        expand(P, t(N,F1/G, Ts), Bound, Tree1, Solved, Solution)
        ;
        Solved = never
    ).

% Caso 3. non foglia, con f minore di bound

expand(P,t(N,F/G, [T|Ts]), Bound, Tree1, Solved, Solution):-
    F =< Bound,
    bestf(Ts,BF),
    min(Bound, BF, NewBound),
    expand([N|P], T, NewBound, T1, Solved1, Solution),
    continue(P, t(N, F/G, [T1,Ts]), Bound, Tree1, Solved1, Solved, Solution).

% Caso 4. non-foglia con sottoalberi vuoti

expand(_,t(_,_,[]),_,_, never, _) :- !.

% Caso 5.  valore maggiore del bound.

cepand(_,Tree, Bound, Tree, no, _) :-
    f(Tree, F),
    F > Bound.

% continue(Path, Tree, Bound, NewTree, SubtreeSolved, TreeSolved, Solution)

continue(_,_,_,_,yes,yes,Solution).

continue(P,t(N,F/G,[T1|Ts]), Bound, Tree1, no, Solved, Solution) :-
    insert(T1, Ts, NTs),
    bestf(NTs, F1)
