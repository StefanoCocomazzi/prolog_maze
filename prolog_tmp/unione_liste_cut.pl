unione([],B,B).
unione([Head|Tail], B, Unione):-
    member(Head, B),
    !,
    unione(Tail,B,Unione).
unione([Head|Tail],B, [Head|Unione]):-
    unione(Tail, B, Unione).