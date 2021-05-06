from math import *
from itertools import combinations

dico = {
    1: [2, 5, 6],
    2: [3, 7],
    3: [4, 8],
    4: [5, 9],
    5: [10],
    6: [8, 9],
    7: [9, 10],
    8: [10],
    9: [],
    10: [],
}

nbCouleur = 3
nbSommet = len(dico)
nbArrete = 0
for i in dico:
    nbArrete += len(dico[i])
nbClause = 85

correspondance = {}
for i in range(nbSommet):
    for k in range(nbCouleur):
        correspondance[i * nbCouleur + k + 1] = "sommet " + str(i + 1) + " couleur " + str(k + 1)

# On imprime la premiere ligne, qui contient le nb de var et le nombre de clauses
print("p cnf " + str(nbSommet * nbCouleur) + " " + str(nbClause))

for i in range(nbSommet):
    for k in range(nbCouleur):
        print(str(i * nbCouleur + k + 1), end=" ")
    print("0")

for i in range(nbSommet):
    liste = []
    for k in range(nbCouleur):
        liste += [i * nbCouleur + k + 1]
    combinaisons = list(combinations(liste, 2))
    for k in combinaisons:
        for j in k:
            print(str(-j), end=" ")
        print("0")

for i in range(nbSommet):
    for j in dico[i+1]:
        for k in range(nbCouleur):
            print(str(-(i * nbCouleur + k + 1)) + " " + str(-((j-1) * nbCouleur + k + 1)) + " 0")