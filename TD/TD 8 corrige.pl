element([X|_],X).
element([_|R],X):- element(R,X).

numero(X):- element([1,2,3],X).

nationalite(X):- element([italien,norvegien,espagnol],X).

couleur(X):- element([rouge,vert,bleu],X).

generate([maison(Num1,Coul1,Nat1), maison(Num2,Coul2,Nat2),maison(Num3,Coul3,Nat3)]):- numero(Num1), couleur(Coul1), nationalite(Nat1), numero(Num2), couleur(Coul2), nationalite(Nat2), numero(Num3), couleur(Coul3), nationalite(Nat3).

regle0([maison(1,_,_),maison(2,_,_),maison(3,_,_)]).

regle1([maison(_,Coul1,_), maison(_,Coul2,_), maison(_,Coul3,_)]):- Coul1 \= Coul2, Coul2 \= Coul3, Coul1 \= Coul3.

regle2([maison(_,_,Nat1), maison(_,_,Nat2), maison(_,_,Nat3)]):- Nat1 \= Nat2, Nat2 \= Nat3, Nat1 \= Nat3.

indice1([maison(_,rouge,_),maison(_,_,espagnol),maison(_,_,_)]).
indice1([maison(_,_,_),maison(_,rouge,_),maison(_,_,espagnol)]).

indice2([maison(_,bleu,norvegien),maison(_,_,_),maison(_,_,_)]).
indice2([maison(_,_,_),maison(_,bleu,norvegien),maison(_,_,_)]).
indice2([maison(_,_,_),maison(_,_,_),maison(_,bleu,norvegien)]).

indice3([maison(_,_,_),maison(_,_,italien),maison(_,_,_)]).

test([M1,M2,M3]):- regle0([M1,M2,M3]), regle1([M1,M2,M3]), regle2([M1,M2,M3]), indice1([M1,M2,M3]), indice2([M1,M2,M3]), indice3([M1,M2,M3]).

solve([M1,M2,M3]):- generate([M1,M2,M3]), test([M1,M2,M3]).
