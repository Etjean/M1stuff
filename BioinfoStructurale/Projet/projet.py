#! usr/bin/env python3
import numpy as np



#Parsing du PDB
def extrait_coords(filepath):
    """retourne une liste de tuple avec les coordonnées"""
    coords = []
    with open(filepath, 'r') as filin:
        for line in filin:
            coord = []
            if line[0:6].strip()=='ATOM' and line[22:26].strip()=='1':
                x = float(line[30:38].strip())
                y = float(line[38:46].strip())
                z = float(line[46:54].strip())
                coords.append((x, y, z))
    return coords

#Calcul d'une distance entre 2 points
def dist(xyz1, xyz2):
    """retourne la distance l entre les coordonnées xyz1 et xyz2 (tuples nécessairement)"""
    x1, y1, z1 = xyz1
    x2, y2, z2 = xyz2
    dist = np.sqrt((x1-x2)**2 + (y1-y2)**2 + (z1-z2)**2)
    return dist
    

#Calcul d'un angle entre 3 points
def angle(xyz1, xyz2, xyz3):
    """retourne l'angle theta entre les coordonnées xyz1, 2, 3 (tuples)"""
    x1, y1, z1 = xyz1
    x2, y2, z2 = xyz2
    x3, y3, z3 = xyz3
    angle = 




















if __name__ == "__main__":
    coords = extrait_coords('water.pdb')
    print(dist(coords[0], coords[1]))
    print(angle(coords[0], coords[1], coords[2])
















