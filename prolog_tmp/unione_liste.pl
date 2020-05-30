unione([],B,B).
unione([Head|Tail],B,Unione):-
    member(Head, B),
    unione(Tail,B,Unione).
unione([Head|Tail],B, [Head|Unione]):-
    \+member(Head, B), 
    unione(Tail, B, Unione).
    

/*     \+ NEGAZIONE PER FALLIMENTO */