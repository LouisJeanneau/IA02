"""
[IA02] TP SAT/Sudoku template python
author:  Sylvain Lagrue & Louis Jeanneau
version: 1.0.2
"""
from pprint import *
from typing import List, Tuple
import subprocess
from itertools import combinations

# alias de types
Variable = int
Literal = int
Clause = List[Literal]
Model = List[Literal]
Clause_Base = List[Clause]
Grid = List[List[int]]

example: Grid = [
    [5, 3, 0, 0, 7, 0, 0, 0, 0],
    [6, 0, 0, 1, 9, 5, 0, 0, 0],
    [0, 9, 8, 0, 0, 0, 0, 6, 0],
    [8, 0, 0, 0, 6, 0, 0, 0, 3],
    [4, 0, 0, 8, 0, 3, 0, 0, 1],
    [7, 0, 0, 0, 2, 0, 0, 0, 6],
    [0, 6, 0, 0, 0, 0, 2, 8, 0],
    [0, 0, 0, 4, 1, 9, 0, 0, 5],
    [0, 0, 0, 0, 8, 0, 0, 7, 9],
]

example2: Grid = [
    [0, 0, 0, 0, 2, 7, 5, 8, 0],
    [1, 0, 0, 0, 0, 0, 0, 4, 6],
    [0, 0, 0, 0, 0, 9, 0, 0, 0],
    [0, 0, 3, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 5, 0, 2, 0],
    [0, 0, 0, 8, 1, 0, 0, 0, 0],
    [4, 0, 6, 3, 0, 1, 0, 0, 9],
    [8, 0, 0, 0, 0, 0, 0, 0, 0],
    [7, 2, 0, 0, 0, 0, 3, 1, 0],
]

empty_grid: Grid = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
]


# fonctions fournies


def write_dimacs_file(dimacs: str, filename: str):
    with open(filename, "w", newline="") as cnf:
        cnf.write(dimacs)


def exec_gophersat(
        filename: str, cmd: str = "gophersat-1.1.6.exe", encoding: str = "utf8") -> Tuple[bool, List[int]]:
    result = subprocess.run([cmd, filename], stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True,
                            encoding=encoding)
    string = str(result.stdout)
    lines = string.splitlines()

    if lines[1] != "s SATISFIABLE":
        return False, []

    model = lines[2][2:].split(" ")

    return True, [int(x) for x in model]


# fonctions maisons


def cell_to_variable(i: int, j: int, val: int) -> int:
    return (i - 1) * 81 + (j - 1) * 9 + val


def variable_to_cell(var: int) -> Tuple[int, int, int]:
    v = var - 1
    return (v // 81) + 1, (v % 81) // 9 + 1, (v % 9) + 1


def at_least_one(vars: List[int]) -> List[int]:
    return vars[:]


def unique(vars: List[int]) -> List[List[int]]:
    return [vars[:]] + [list(a) for a in combinations([-x for x in vars], 2)]


def create_cell_constraints() -> List[List[int]]:
    res: List[List[int]] = [[]]
    for i in range(1, 10):
        for j in range(1, 10):
            res.extend(unique([cell_to_variable(i, j, var) for var in range(1, 10)]))
    return res[1:]


def create_line_constraints() -> List[List[int]]:
    res: List[List[int]] = [[]]
    for i in range(1, 10):
        for var in range(1, 10):
            res.extend([at_least_one([cell_to_variable(i, j, var) for j in range(1, 10)])])
    return res[1:]


def create_column_constraints() -> List[List[int]]:
    res: List[List[int]] = [[]]
    for j in range(1, 10):
        for var in range(1, 10):
            res.extend([at_least_one([cell_to_variable(i, j, var) for i in range(1, 10)])])
    return res[1:]


def create_box_constraints() -> List[List[int]]:
    box = [(0, 0)]
    res: List[List[int]] = [[]]
    for i in range(1, 4):
        for j in range(1, 4):
            box = box + [(i, j)]
    box = box[1:]
    for hor in range(3):
        for vert in range(3):
            for couleur in range(1, 10):
                temp = []
                for (i, j) in box:
                    temp.append(cell_to_variable(hor * 3 + i, vert * 3 + j, couleur))
                res.append(at_least_one(temp[:]))
    return res[1:]


def create_value_constraints(grid: List[List[int]]) -> List[List[int]]:
    res: List[List[int]] = []
    for i in range(9):
        for j in range(9):
            if grid[i][j]:
                res.append([cell_to_variable(i + 1, j + 1, grid[i][j])])
    return res


def generate_problem(grid: List[List[int]]) -> List[List[int]]:
    res: List[List[int]] = []
    res.extend(create_cell_constraints())
    res.extend(create_line_constraints())
    res.extend(create_column_constraints())
    res.extend(create_box_constraints())
    res.extend(create_value_constraints(grid))
    return res


def clauses_to_dimacs(clauses: List[List[int]], nb_vars: int) -> str:
    res: str = ""
    res += "p cnf " + str(nb_vars) + " " + str(len(clauses)) + "\n"
    for clause in clauses:
        for literal in clause:
            res += str(literal) + " "
        res += "0\n"
    return res


def model_to_grid(model: List[int], nb_vals: int = 9) -> List[List[int]]:
    res: List[List[int]] = []
    temp: List[int] = []
    for i in range(nb_vals):
        temp.append(0)
    for i in range(nb_vals):
        res.append(temp[:])
    for literal in model:
        if literal > 0:
            (a, b, c) = variable_to_cell(literal)
            res[a-1][b-1] = c
    return res[:]


def solveur_sudoku(grid: List[List[int]]):
    write_dimacs_file(clauses_to_dimacs(generate_problem(grid), 9*9*9), "fichier_sudoku_solveur.cnf")
    (boolansw, listansw) = exec_gophersat("fichier_sudoku_solveur.cnf")
    gridansw = model_to_grid(listansw, 9)
    if boolansw:
        pprint(gridansw)
    return


# fonction principale

def main():
    pass


if __name__ == "__main__":
    main()
