#! usr/bin/env python3
import numpy as np



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
    """retourne l'angle theta entre les coordonnées xyz1, 2, 3"""
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




if __name__ == "__main__":
    #Paramètres définis par CHARMM :
    #distance à l'équilibre OH-H (en A)
    l_eq = 0.9572
    #constante de force de liaison (en kcal.mol-1.A-2)
    k_liaison = 450.000
    #angle à l'équilibre H-O-H (en degrés)
    th_eq = 1.81514242
    #constante de force d'angle (en kcal.mol-1.rad-2)
    k_angle = 55.000
    
    #Parsing du pdb
    coords = extrait_coords('water.pdb')
    xyzO = coords[0]
    xyzH1 = coords[1]
    xyzH2 = coords[2]
    vectOH1 = xyzH1 - xyzO
    vectOH2 = xyzH2 - xyzO
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
    print(epot)
















