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
petitFils(X,Y) :- homme(Y), parent(X,Z), parent(Z,Y).
petiteFille(X,Y) :- femme(Y), parent(X,Z), parent(Z,Y).
memePere(X,Y) :- pere(Z,X), pere(Z, Y).
memeMere(X,Y) :- mere(Z,X), mere(Z,Y).
memeParent(X,Y) :- parent(Z,X), parent(Z,Y), parent(W, X), parent(S, Y), dif(W, S), dif(W, Z), dif(S, Z).
memeParents(X,Y) :-  parent(Z,X), parent(Z,Y),  parent(W,X), parent(W,Y), dif(W,Z).
frere(X,Y) :- memeParents(X,Y), homme(X).
soeur(X,Y) :- memeParents(X,Y), femme(X).
demiFrere(X,Y) :- memeParent(X,Y), homme(X).
demiSoeur(X,Y) :- memeParent(X,Y), femme(X).
oncle(X,Y) :- frere(X,Z), parent(Z,Y).
tante(X,Y) :- soeur(X,Z), parent(Z,Y).
neveu(X,Y) :- fils(X,Z), or(frere(Z,Y), soeur(Z,Y)).


niece(X,Y) ( X est la nièce de Y )
cousin(X,Y) ( X est le cousin de Y )
cousine(X,Y) ( X est la cousine de Y )
gendre(X,Y) ( X est le gendre de Y )
bru(X,Y) ( X est la bru de Y )
maratre(X,Y) ( X est la marâtre de Y , au sens de « la reine est la marâtre de Blanche
Neige »)
belleMere(X,Y) ( X est la belle-mère de Y , dans l’acceptation la plus large)
beauPere(X,Y) ( X est le beau-père de Y )
ascendant(X,Y) ( X est un ascendant de Y )
descendant(X,Y) ( X est un descendant de Y )
lignee(X,Y) ( X est sur la même lignée que Y )
parente(X,Y) ( X a un lien de parenté avec Y , c.-à.-d. ils sont dans la même partie de
l’arbre généalogique)


homme(khaled).
parent(khaled,leila).
