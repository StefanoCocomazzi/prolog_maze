genitore(edoardo, clara).
genitore(virginiaBourbon, clara).
genitore(edoardo, gianni).
genitore(virginiaBourbon, gianni).
genitore(edoardo, susanna).
genitore(virginiaBourbon, susanna).
genitore(edoardo, mariasole).
genitore(virginiaBourbon, mariasole).
genitore(edoardo, crisitana).
genitore(virginiaBourbon, crisitana).
genitore(edoardo, giorgio).
genitore(virginiaBourbon, giorgio).
genitore(edoardo, umberto).
genitore(virginiaBourbon, umberto).
genitore(gianni, edoardo2).
genitore(marella, edoardo2).
genitore(gianni, margherita).
genitore(marella, margherita).
genitore(mariasole, viriginia).
genitore(ranieri, virginia).
genitore(mariasole, argenta).
genitore(ranieri, argenta).
genitore(mariasole, cintia).
genitore(ranieri, cintia).
genitore(mariasole, bernardino).
genitore(ranieri, bernardino).
genitore(umberto, giovanni).
genitore(antonella, giovanni).
genitore(umberto, andrea).
genitore(allegra, andrea).
genitore(umberto, anna).
genitore(allegra, anna).
genitore(margherita, johnElkann).
genitore(alain, johnElkann).
genitore(margherita, lapoElkann).
genitore(alain, lapoElkann).
genitore(margherita, ginevraElkann).
genitore(alain, ginevraElkann).
genitore(giovanni, virginiaAnna).
genitore(howe, virginiaAnna).
genitore(andrea, baya).
genitore(emma, baya).
genitore(andrea, giacomo).
genitore(emma, giacomo).
genitore(andrea, livia).
genitore(deniz, livia).

antenato(X,Y):-genitore(X,Y).
antenato(X,Y):-genitore(X,Z), antenato(Z,Y).

% Fratello Germano
fratelloGermano(X,Y):-
    genitore(A,X), genitore(A,Y), 
    genitore(B,X), genitore(B,Y),
    A \== B, X \== Y.
    

% Fratello Unilaterale
fratelloUnilaterale(X,Y):-
    genitore(C,X), genitore(C,Y), X \== Y,
    genitore(A,X), A \== C,
    genitore(B,Y), B \== C,
    A \== B.
