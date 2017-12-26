#! usr/bin/env python3
import numpy as np

#Paramètres définis par CHARMM :
#distance à l'équilibre OH-H (en A)
l_eq = 0.9572
#constante de force de liaison (en kcal.mol-1.A-2)
k_liaison = 450.000
#angle à l'équilibre H-O-H (en degrés)
th_eq = 1.81514242
#constante de force d'angle (en kcal.mol-1.rad-2)
k_angle = 55.000


def extrait_coords(filepath):
    """retourne une liste d'array numpy avec les coordonnées"""
    coords = []
    with open(filepath, 'r') as filin:
        for line in filin:
            coord = []
            if line[0:6].strip()=='ATOM' and line[22:26].strip()=='1':
                x = float(line[30:38].strip())
                y = float(line[38:46].strip())
                z = float(line[46:54].strip())
                coords.append(np.array([x, y, z]))
    return coords

def angle(vect1, vect2):
    """retourne l'angle theta entre les vecteurs 1 et 2"""
    dot = np.dot(vect1, vect2)
    norm1 = np.linalg.norm(vect1)
    norm2 = np.linalg.norm(vect2)
    return np.arccos(dot/(norm1*norm2))

def e_liaison(l, l_eq, k_liaison):
    """retourne l'énergie de liaison"""
    return (1/2)*k_liaison*(l-l_eq)**2

def e_angle(th, th_eq, k_angle):
    """retourne l'énergie d'angle"""
    return (1/2)*k_angle*(th-th_eq)**2

def e_potentielle(xyz):
    """retourne l'énergie potentielle totale"""
    vectOH1 = xyz[3:6] - xyz[0:3]
    vectOH2 = xyz[6:9] - xyz[0:3]
    #Energies de liaison
    lOH1 = np.linalg.norm(vectOH1)
    lOH2 = np.linalg.norm(vectOH2)  
    el1 = e_liaison(lOH1, l_eq, k_liaison)
    el2 = e_liaison(lOH2, l_eq, k_liaison)
    #Energie d'angle
    th = angle(vectOH1, vectOH2)
    ea = e_angle(th, th_eq, k_angle)
    #Energie totale
    epot = el1 + el2 + ea
    return epot

def deriv_partielle(xyz, i, delta):
    """calcule de la derivée partielle en xi"""
    dxi = np.zeros(9)
    dxi[i] = delta
    deriv = (e_potentielle(xyz+dxi) - e_potentielle(xyz-dxi)) / (2*delta)
    return deriv

def calc_gradient(xyz, delta):
    """calcule le gradient d'énergie potentielle"""
    grad = np.zeros(9)
    for i in range(9):
        grad[i] = deriv_partielle(xyz, i, delta)
    return grad




if __name__ == "__main__": 
    #Parsing du pdb
    coords = extrait_coords('water.pdb')
    xyzO = coords[0]
    xyzH1 = coords[1]
    xyzH2 = coords[2]
    #Vecteur des coordonnées : [xO, yO, zO, xH1, yH1, zH1, xH2, yH2, zH2]
    xyz = np.concatenate([coords[0], coords[1], coords[2]])
    print("Vecteur des coordonnées :\n", xyz, end='\n\n')
    epot = e_potentielle(xyz)
    print("Energie potentielle :\n", epot, end = '\n\n')
    grad = calc_gradient(xyz, 0.0001)
    print("Gradient :\n", grad, end='\n\n')















