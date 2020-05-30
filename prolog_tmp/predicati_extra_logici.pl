% Programma che, data una lista di numeri interi, somma i valori positivi.
% Contestualmente, tener traccia di quali elementi sono negativi e quanti sono.

:-dynamic(quantiNegativi/1).
:-dynamic(valoreNegativo/1).
quantiNegativi(0).

sommaPositivi([], 0).
sommaPositivi([Head|Tail],Somma):-
    Head>=0,
    !,
    sommaPositivi(Tail, SommaTail),
    Somma is Head + SommaTail.

sommaPositivi([Head|Tail],Somma):-
    assert(valoreNegativo(Head)),
    quantiNegativi(N),
    N1 is N + 1,
    retractall(quantiNegativi(_)),
    assert(quantiNegativi(N1)),    
    sommaPositivi(Tail, Somma).
