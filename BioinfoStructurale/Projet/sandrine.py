#! /usr/bin/env python
# -*- coding: utf-8 -*-

# http://uel.unisciel.fr/chimie/modelisation/modelisation_ch02/co/1-2_energie_de_deformation.html


#################
#    IMPORTS    #
#################
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
    """ Retourne un vecteur avec les coordonnées xyz de chaque atome d'un fichier PDB. """
    coords = []
    with open(filepath, 'r') as filin:
        for line in filin:
            if line[0:6].strip()=='ATOM':
                x = float(line[30:38].strip())
                y = float(line[38:46].strip())
                z = float(line[46:54].strip())
                coords += [x, y, z]
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
    vect_OH1 = coords[0:3] - coords[3:6]
    vect_OH2 = coords[0:3] - coords[6:9]

    # Energies d'élongation de liaison
    l_OH1 = np.linalg.norm(vect_OH1)
    e_OH1 = e_bond(l_OH1)

    l_OH2 = np.linalg.norm(vect_OH2)
    e_OH2 = e_bond(l_OH2)

    # Energie de déformation angulaire
    th = angle(vect_OH1, vect_OH2)
    e_th = e_angle(th)

    # Energie d'interaction totale
    epot = e_OH1 + e_OH2 + e_th

    return epot



#________________________________________________________________________________________________
#________________________________________________________________________________________________
def calc_gradient(coords):
    """ Calcul du gradient de l'énergie potentielle. """
    gradient = []
    for i in range(len(coords)):
        coords_plus_delta = coords.copy()
        coords_plus_delta[i] += DELTA
        coords_less_delta = coords.copy()
        coords_less_delta[i] -= DELTA
        gradient.append((e_potential(coords_plus_delta) - e_potential(coords_less_delta)) / (2*DELTA))

    return np.array(gradient)


#________________________________________________________________________________________________
#________________________________________________________________________________________________
def line_search(coords, grad):
    """Renvoie le pas optimal pour la minimisation"""
    gold = (1+np.sqrt(5))/2
    step_a = -0.1
    step_b = 0
    step_c = -gold*step_a
    epot_a = e_potential(coords - step_a*grad)
    epot_b = e_potential(coords - step_b*grad)
    epot_c = e_potential(coords - step_c*grad)
    #initialisation de l'encadrement du minimum : recherche d'un encadrement adapté
    while epot_a < epot_b or epot_c < epot_b:
        step_a *= 10
        step_c *= 10
        epot_a = e_potential(coords - step_a*grad)
        epot_c = e_potential(coords - step_c*grad)
    #réduction de l'encadrement par la méthode du nombre d'or
    for _ in range(10):
        if (step_c-step_b) >= (step_b-step_a):
            step_d = (step_c+gold*step_b)/(gold+1)
            epot_d = e_potential(coords - step_d*grad)
            if epot_d <= epot_b:
                step_a = step_b
                step_b = step_d
            else:
                step_c = step_d
        else:
            step_d = (step_a+gold*step_b)/(gold+1)
            epot_d = e_potential(coords - step_d*grad)
            if epot_d <= epot_b:
                step_c = step_b
                step_b = step_d
            else:
                step_a = step_d

        epot_a = e_potential(coords - step_a*grad)
        epot_b = e_potential(coords - step_b*grad)
        epot_c = e_potential(coords - step_c*grad)

    return step_b



#________________________________________________________________________________________________
#________________________________________________________________________________________________
def steepest_descent(coords, threshold, max_iter):
    """" Méthode de Steepest Descent. """
    n_iter = 1
    grms = np.linalg.norm(calc_gradient(coords))

    while(grms > threshold and n_iter <= max_iter):
        grad = calc_gradient(coords)
        step = line_search(coords, grad)
        coords = coords - step*grad
        grms = np.linalg.norm(grad)
        #print("Etape", n_iter, ": GRMS =", grms, end="\n")
        n_iter += 1
        time.sleep(0)

    print("Nombre d'itérations : ", n_iter-1, "    GRMS : ", grms)

    if(n_iter > max_iter):
        print("L'algorithme n'a pas convergé.")

    return coords



##############
#    MAIN    #
##############

if __name__ == "__main__":

    # Coordonnées de départ : [O, H1, H2]
    coords = extract_coords('water.pdb')
    print("Array des coordonnées de départ :\n", coords, end='\n\n')

    # Energie potentielle de départ
    epot = e_potential(coords)
    print("Energie potentielle de départ :\n", epot, end = '\n\n')

    # Gradient de départ
    grad = calc_gradient(coords)
    print("Gradient de départ :\n", grad, end = '\n\n')
    
    # GRMS de départ
    grms = np.linalg.norm(coords)
    print("GRMS de départ :\n", grms, end='\n\n')
    
    mini = steepest_descent(coords, 0.00001, 100)
    print("Vecteur des coordonnées après minimisation :\n", mini, end='\n\n')



    
    
    
    
    
    
    
    
    
    
    
    
    
