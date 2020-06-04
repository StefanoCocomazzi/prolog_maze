applicable(east, pos(Row, Col)):-
    columns(Num),
    Col < Num,
    NextCol is Col + 1,
    \+wall(pos(Row, NextCol)).


applicable(ovest ,pos(Row,Col)):-
    Col > 1,
    NextCol is Col - 1,
    \+wall(pos(Row, NextCol)).

applicable(sud ,pos(Row,Col)):-
    num_righe(Num),
    Row < Num,
    NextRow is Row + 1,
    \+wall(pos(NextRow, Col)).

applicable(nord ,pos(Row,Col)):-
    Row > 1,
    NextRow is Row - 1,
    \+wall(pos(NextRow, Col)).

transform(est,pos(Row,Col), pos(Row, NextCol)):- NextCol is Col + 1.
transform(ovest,pos(Row,Col), pos(Row, NextCol)):- NextCol is Col - 1.
transform(nord,pos(Row,Col), pos(NextRow, Col)):- NextRow is Row - 1.
transform(sud,pos(Row,Col), pos(NextRow, Col)):- NextRow is Row + 1.
