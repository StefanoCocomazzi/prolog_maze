cerca_soluzione(Soluzione):-
    profondita_massima(Limite),
    iterative_deepening(Limite, Soluzione).

profondita_massima(P):-
    num_righe(W),
    num_colonne(H),
    findall(X, occupata(X), Risultato),
    length(Risultato, Occupate),
    P is ((W * H) - 2) - Occupate.