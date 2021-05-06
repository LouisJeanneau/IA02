pere(X,Y) :- parent(X,Y), homme(X).
mere(X,Y) :- parent(X,Y), femme(X).
epoux(X,Y) :- couple(X,Y), homme(X).
epouse(X,Y) :- couple(X,Y), femme(Y).
fils(X,Y) :- homme(X), parent(Y,X).
fille(X,Y) :- femme(X), parent(Y,X).
enfant(X,Y) :- parent(Y,X).
grandPere(X,Y) :- homme(X), parent(X,Z), parent(Z,Y).
grandMere(X,Y) :- femme(X), parent(X,Z), parent(Z,Y).
grandParent(X,Y) :- parent(X,Z), parent(Z,Y).
petitFils(X,Y) :- homme(X), parent(Y, Z), parent(Z, X).
petiteFille(X,Y) :- femme(X), parent(Y,Z), parent(Z,X).
memePere(X,Y) :- pere(Z,X), pere(Z, Y), X\==Y.
memeMere(X,Y) :- mere(Z,X), mere(Z,Y), X\==Y.
memeParent(X,Y) :- parent(Z,X), parent(Z,Y), X\==Y.
memeParents(X,Y) :-  parent(Z,X), parent(Z,Y),  parent(W,X), parent(W,Y), W\==Z, X\==Y.
frere(X,Y) :- memeParents(X,Y), homme(X), X\==Y.
soeur(X,Y) :- memeParents(X,Y), femme(X), X\==Y.
demiFrere(X,Y) :- memeParent(X,Y), homme(X), X\==Y.
demiSoeur(X,Y) :- memeParent(X,Y), femme(X), X\==Y.
oncle(X,Y) :- frere(X,Z), parent(Z,Y).
tante(X,Y) :- soeur(X,Z), parent(Z,Y).
neveu(X,Y) :- fils(X,Z), frere(Z,Y).
neveu(X,Y) :- fils(X,Z), soeur(Z,Y).
niece(X,Y) :- fille(X,Z), frere(Z,Y).
niece(X,Y) :- fille(X,Z), soeur(Z,Y).
cousin(X,Y) :- homme(X), parent(I,X), memeParent(I,J), parent(J, Y), X\==Y.
cousine(X,Y) :- femme(X), parent(I,X), memeParent(I,J), parent(J, Y), X\==Y.
gendre(X,Y) :- homme(X), couple(X,Z), fille(Z, Y).
bru(X,Y) :- femme(X), couple(X,Z), fils(Z, Y).
maratre(X,Y) :- femme(X), epouse(X, Z), pere(Z,Y), mere(Q,Y), X\==Q.
belleMere(X,Y) :- femme(X), couple(X, Z), parent(Z,Y), mere(Q,Y), X\==Q.
beauPere(X,Y) :- homme(X), couple(X, Z), parent(Z,Y), pere(Q,Y), X\==Q.


/*
 * ascendant(X,Y) ( X est un ascendant de Y )
 * descendant(X,Y) ( X est un descendant de Y 
 * lignee(X,Y) ( X est sur la même lignée que Y )
 * parente(X,Y) ( X a un lien de parenté avec Y , c.-à.-d. ils sont dans la même partie del’arbre généalogique)
 */

homme(khaled).
homme(ben).
femme(amumu).
femme(leila).
femme(morg).
parent(khaled,leila).
parent(khaled, morg).
parent(leila, ben).
parent(morg, amumu).

