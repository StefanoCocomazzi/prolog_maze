euristica_eulero(pos(X,Y), Risultato):-
    finale(pos(X1,Y1)),
    Risultato is sqrt(((X - X1) * (X - X1)) + ((Y - Y1) * (Y - Y1))).
    
euristica_manhattan(pos(X,Y), Risultato):-
    finale(pos(X1,Y1)),
    Risultato is abs(X - X1) + abs(Y - Y1).