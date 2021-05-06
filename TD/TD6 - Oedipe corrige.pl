%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                  %%
%% Inférence arbre généalogique                     %%
%%                                                  %%
%% prédicats de base : couple, homme, femme, parent %%
%%                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pere(X,Y) :- homme(X), parent(X,Y).

mere(X,Y) :- femme(X), parent(X,Y).

grandparent(X,Z) :- parent(X,Y), parent(Y,Z).

grandpere(X,Z) :- homme(X), parent(X,Y), parent(Y,Z).
grandmere(X,Z) :- femme(X), parent(X,Y), parent(Y,Z).


% epoux(X,Y) :- homme(X), (couple(X,Y) ; couple(Y,X)).
epoux(X,Y) :- homme(X), couple(X,Y).
epoux(X,Y) :- homme(X), couple(Y,X).

% epouse(X,Y) :- femme(X), (couple(X,Y) ; couple(Y,X)).
epouse(X,Y) :- femme(X), couple(X,Y).
epouse(X,Y) :- femme(X), couple(Y,X).



enfant(X,Y) :- parent(Y,X).
fils(X,Y) :- homme(X),  enfant(X,Y).
fille(X,Y) :- femme(X), enfant(X,Y).

petitenfant(X,Y) :- grandparent(Y,X).
petitfils(X,Y) :- homme(X), petitenfant(X,Y).
petitefille(X,Y) :- femme(X), petitenfant(X,Y).

memeparent(X,Y)  :- parent(Z, X), parent(Z, Y), dif(X,Y). 
memepere(X,Y) :- homme(Z), parent(Z, X), parent(Z, Y), dif(X,Y).
mememere(X,Y) :- femme(Z), parent(Z ,X), parent(Z, Y), dif(X,Y).
memesparents(X,Y) :-  memepere(X,Y), mememere(X,Y).

frere(X,Y) :- homme(X), memesparents(X,Y).
soeur(X,Y) :- femme(X), memesparents(X,Y).
demisoeur(X,Y) :- femme(X), memeparent(X,Y), \+(memesparents(X,Y)).
demifrere(X,Y) :- homme(X), memeparent(X,Y), \+(memesparents(X,Y)).

oncle(X,Y) :- frere(X,Z), parent(Z, Y).
oncle(X,Y) :- epoux(X,Z), soeur(Z, W), parent(W,Y).
oncle(X,Y) :- demifrere(X,Z), parent(Z, Y).
oncle(X,Y) :- epoux(X,Z), demisoeur(Z, W), parent(W,Y).
%oncle(X,Y) :- couple(X, Z), soeur(Z, W), parent(W,Y).
%oncle(X,Y) :- couple(Z, X), soeur(Z, W), parent(W,Y).

tante(X,Y) :- soeur(X,Z), parent(Z, Y).
tante(X,Y) :- epouse(X,Z), frere(Z, W), parent(W,Y).
tante(X,Y) :- demisoeur(X,Z), parent(Z, Y).
tante(X,Y) :- epouse(X,Z), demifrere(Z, W), parent(W,Y).
%tante(X,Y) :- couple(X, Z), frere(Z, W), parent(W,Y).
%tante(X,Y) :- couple(Z, X), frere(Z, W), parent(W,Y).


neveu(X,Y) :- homme(X), oncle(Y,X).
neveu(X,Y) :- homme(X), tante(Y, X).

niece(X,Y) :- femme(X), oncle(Y,X).
niece(X,Y) :- femme(X), tante(Y, X).


% cousin(X,Y) :- homme(X), (oncle(Z, X) ; tante(Z, X)), parent(Z, Y).
cousin(X,Y) :- homme(X), oncle(Z, X), parent(Z, Y).
cousin(X,Y) :- homme(X), tante(Z, X), parent(Z, Y).
% cousin(X,Y) :- homme(X), memegrandparents(X,Y), X \= Y.

% cousine(X,Y) :- femme(X), (oncle(Z, X) ; tante(Z, X)), parent(Z, Y).
cousine(X,Y) :- femme(X), oncle(Z, X), parent(Z, Y).
cousine(X,Y) :- femme(X), tante(Z, X), parent(Z, Y).

gendre(X,Y) :- epoux(X,Z), parent(Y, Z).
bru(X,Y) :- epouse(X,Z), parent(Y, Z).

bellemere(X,Y) :- femme(X), (gendre(Y,X) ; bru(Y,X) ; (epouse(X,Z), parent(Z, Y)), \+ mere(X, Y)).

beaupere(X,Y) :- homme(X), (gendre(Y,X) ; bru(Y,X) ; (epoux(X,Z), parent(Z, Y)), \+ (pere(X, Y))).

% ascendant(X,Y) :- parent(X,Y) ; (parent(Z,Y), ascendant(X,Z)).
ascendant(X,Y) :- parent(X,Y).
ascendant(X,Y) :- parent(Z,Y), ascendant(X,Z).

descendant(X,Y) :- ascendant(Y,X).

% lignee(X,Y) :- ascendant(X, Y) ; descendant(X, Y).
lignee(X,Y) :- ascendant(X, Y).
lignee(X,Y) :- descendant(X, Y).


parente(X,Y) :-  ascendant(Z,X), ascendant(Z,Y), X \= Y.

% Base de faits famille d'Oedipe
% Hommes
homme(cadmos).
homme(polydore).
homme(echion).
homme(zeus).
homme(labdacos).
homme(penthee).
homme(dionysos).
homme(menecee).
homme(laios).
homme(creon).
homme(oedipe).
homme(hemon).
homme(eteocle). 
homme(polynice). 

% Femmes
femme(harmonie).
femme(agave).
femme(semele).
femme(jocaste).
femme(eurydice).
femme(antigone).
femme(ismene).

% Couples
couple(oedipe, jocaste).
couple(laios, jocaste).
couple(cadmos, harmonie).
couple(echion, agave).
couple(zeus, semele).
couple(creon, eurydice).

% Parents
parent(oedipe, polynice).
parent(oedipe, eteocle).
parent(oedipe, ismene).
parent(oedipe, antigone).
parent(jocaste, polynice).
parent(jocaste, eteocle).
parent(jocaste, ismene).
parent(jocaste, antigone).
parent(laois, oedipe).
parent(jocaste, oedipe).
parent(creon, hemon).
parent(eurydice, hemon).
parent(menecee, jocaste).
parent(menecee, creon).
parent(penthee, menecee).
parent(labdacos, laios).
parent(polydore, labdacos).
parent(agave, penthee).
parent(echion, penthee).
parent(semele, dionysos).
parent(zeus, dionysos).
parent(cadmos, polydore).
parent(cadmos, echion).
parent(cadmos, semele).
parent(harmonie, polydore).
parent(harmonie, echion).
parent(harmonie, semele).
