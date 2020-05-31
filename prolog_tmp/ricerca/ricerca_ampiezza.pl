%CODA
%VISITATI
%START
%END

%ricerca_ampiezza(Start, Visitati, Coda, Soluzione).

bfs(Soluzione) :-
    iniziale(Start),
    ricerca_ampiezza(Start, [Start], [Start], Soluzione).

ricerca_ampiezza(Nodo,_,_,Soluzione):-
    finale(Nodo),!.

ricerca_ampiezza(Nodo, Visitati, NuovaCoda ,Soluzione):-
    findall(X, applicabile(X, Nodo), AzioniApplicabili),
    espandi(Nodo, AzioniApplicabili, Visitati, NuovaCoda).


espandi(Nodo, [], _, NuovaCoda) :-
    
    




    
