applicabile(est ,pos(Riga,Colonna)):-
    num_colonne(NC),
    Colonna < NC,
    ColonnaAdiacente is Colonna + 1,
    \+occupata(pos(Riga, ColonnaAdiacente)).

applicabile(ovest ,pos(Riga,Colonna)):-
    Colonna > 1,
    ColonnaAdiacente is Colonna - 1,
    \+occupata(pos(Riga, ColonnaAdiacente)).

applicabile(sud ,pos(Riga,Colonna)):-
    num_righe(NR),
    Riga < NR,
    RigaAdiacente is Riga + 1,
    \+occupata(pos(RigaAdiacente, Colonna)).

applicabile(nord ,pos(Riga,Colonna)):-
    Riga > 1,
    RigaAdiacente is Riga - 1,
    \+occupata(pos(RigaAdiacente, Colonna)).

trasforma(est,pos(Riga,Colonna), pos(Riga, ColonnaDx)):- ColonnaDx is Colonna + 1.
trasforma(ovest,pos(Riga,Colonna), pos(Riga, ColonnaSx)):- ColonnaSx is Colonna - 1.
trasforma(nord,pos(Riga,Colonna), pos(RigaSu, Colonna)):- RigaSu is Riga - 1.
trasforma(sud,pos(Riga,Colonna), pos(RigaGiu, Colonna)):- RigaGiu is Riga + 1.