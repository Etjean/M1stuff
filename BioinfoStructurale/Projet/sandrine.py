#! /usr/bin/env python
# -*- coding: utf-8 -*-

# http://uel.unisciel.fr/chimie/modelisation/modelisation_ch02/co/1-2_energie_de_deformation.html


#################
#    IMPORTS    #
#################
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np



##########################
#    DEFINE CONSTANTS    #
##########################

# Distance d'équilibre standard O-H (en A)
L_EQ = 0.9572
# Constante de force d'élongation de liaison O-H (en kcal.mol-1.A-2)
K_BOND = 450.000
# Angle de valence standard H-O-H (en degrés)
TH_EQ = 1.81514242
# Constante de force de déformation angulaire H-O-H (en kcal.mol-1.rad-2)
K_ANGLE = 55.000
# Pas pour le calcul de la dérivée
DELTA = 0.0001



###################
#    FUNCTIONS    #
###################

#________________________________________________________________________________________________
#________________________________________________________________________________________________
def extract_coords(filepath):
    """ Retourne un array numpy (n_atom, 3) avec les coordonnées xyz de chaque atome d'un fichier PDB. """
    coords = []
    with open(filepath, 'r') as filin:
        for line in filin:
            if line[0:6].strip()=='ATOM':
                x = float(line[30:38].strip())
                y = float(line[38:46].strip())
                z = float(line[46:54].strip())
                coords.append([x, y, z])
    return np.array(coords)


#________________________________________________________________________________________________
#________________________________________________________________________________________________
def angle(vect1, vect2):
    """ Retourne l'angle theta entre les vecteurs 1 et 2. """
    dot = np.dot(vect1, vect2)
    norm1 = np.linalg.norm(vect1)
    norm2 = np.linalg.norm(vect2)
    return np.arccos(dot/(norm1*norm2))


#________________________________________________________________________________________________
#________________________________________________________________________________________________
def e_bond(l):
    """ Retourne l'énergie de liaison. """
    return (1/2)*K_BOND*(l-L_EQ)**2


#________________________________________________________________________________________________
#________________________________________________________________________________________________
def e_angle(th):
    """ Retourne l'énergie d'angle. """
    return (1/2)*K_ANGLE*(th-TH_EQ)**2


#________________________________________________________________________________________________
#________________________________________________________________________________________________
def e_potential(coords):
    """ Retourne l'énergie totale du champs de forces. """
    vect_x1x2 = coords[0,:] - coords[1,:]
    vect_x2x3 = coords[0,:] - coords[2,:]

    # Energies d'élongation de liaison
    l_x1x2 = np.linalg.norm(vect_x1x2)
    l_x2x3 = np.linalg.norm(vect_x2x3)
    e_x1x2 = e_bond(l_x1x2)
    e_x2x3 = e_bond(l_x2x3)

    # Energie de déformation angulaire
    th = angle(vect_x1x2, vect_x2x3)
    e_th = e_angle(th)

    # Energie d'interaction totale
    epot = e_x1x2 + e_x2x3 + e_th

    return epot



#________________________________________________________________________________________________
#________________________________________________________________________________________________
def calc_gradient(coords):
    """ Calcul du gradient de l'énergie potentielle. """
    gradient = np.zeros(coords.size)
    for i, Xi in enumerate(np.nditer(coords)):
        coords_A = coords.flatten()
        coords_B = coords.flatten()
        coords_A[i] += DELTA
        coords_B[i] -= DELTA
        coords_A = np.reshape(coords_A, (round(coords.size/3), 3))
        coords_B = np.reshape(coords_B, (round(coords.size/3), 3))
        gradient[i] = (e_potential(coords_A) - e_potential(coords_B)) / (2*DELTA)
    return np.reshape(gradient, (round(coords.size/3), 3))



#________________________________________________________________________________________________
#________________________________________________________________________________________________
def steepest_descent(coords, step, threshold, max_iter):
    """" Méthode de Steepest Descent. """
    n_iter = 1
    grms = np.sqrt((np.sum(calc_gradient(coords)**2))/coords.size)

    while(grms > threshold and n_iter <= max_iter):
        coords = coords - step*calc_gradient(coords)
        grms = np.sqrt((np.sum(calc_gradient(coords)**2))/coords.size)
        #print("Etape", n_iter, ": GRMS =", grms, end="\n")
        n_iter += 1

    print("Nombre d'itérations :", n_iter-1, "    GRMS : ", grms)

    if(n_iter > max_iter):
        print("L'algorithme n'a pas convergé.")

    return coords



##############
#    MAIN    #
##############
#prendre une seule molecule d'eau et il faudra leur fournir un pdb avec une seule molecule d'eau.
#mauvaise representaton du gradient (c'est un veceur, pas une matrice)
#du coup, calcul du grms pas bon (c'est un scalaire, pas un vecteur)
#mettre aux normes pep8
#soit max_iter soit grms_threshold, pas les 2.
#utiliser linalg.norm() plutot que sqrt(sum())
#Généralisation = pas une bonne idée, et pas demandé => mettre des noms de variables spécifiques à H2O
#uniformiser, soit anglais, soit français.
#représentation matplotlib ? j'ai pas pu tester.

if __name__ == "__main__":

    # Coordonnées : [O, H1, H2]
    coords = extract_coords('water.pdb')
    print("Array des coordonnées de départ :\n", coords, end='\n\n')

    fig = plt.figure()
    ax = plt.axes(projection='3d')

    z = coords[:,0]
    x = coords[:,1]
    y = coords[:,2]

    ax.scatter(x, y, z, '-b')

    # Energie potentielle
    epot = e_potential(coords)
    print("Energie potentielle de départ :\n", epot, end = '\n\n')

    grad = calc_gradient(coords)
    grms = np.sqrt((sum(grad**2))/coords.size)
    print("GRMS de départ :\n", grms, end='\n\n')

    mini = steepest_descent(coords, 0.0002, 0.00001, 1000)
    print("Vecteur des coordonnées après minimisation :\n", mini, end='\n\n')