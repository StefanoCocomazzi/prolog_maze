% somma gli elementi di una lista di interi
%somma(ListaInteri, SommaElementi)
somma([],0).

somma([Head|Tail], SommaElementi):-somma(Tail, SommaCoda), SommaElementi is Head + SommaCoda.

