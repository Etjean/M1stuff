#! /usr/bin/env python
# -*- coding: utf-8 -*-



#################
#    IMPORTS    #
#################
import numpy as np
import os
import sys



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
                coords += [x,y,z]
    
    if coords == [] :
        print("Erreur de lecture du fichier.")
        sys.exit()

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
def steepest_descent(coords, step, threshold, max_iter, save=True, filepath='molecule.pdb'):
    """" Méthode de Steepest Descent. Retourne les coordonnées finales. """
    n_iter = 0
    coords_all = [coords]
    grms = [np.linalg.norm(calc_gradient(coords))]
    vpot = [e_potential(coords)]

    while(grms[-1] > threshold and n_iter < max_iter):
        coords_all.append(coords_all[-1] - step*calc_gradient(coords_all[-1]))
        grms.append(np.linalg.norm(calc_gradient(coords_all[-1])))
        vpot.append(e_potential(coords_all[-1]))
        n_iter += 1

    print("STEEPEST DESCENT\nNombre d'itérations :", n_iter-1, "\nGRMS : ", grms[-1], "\nVpot : ", vpot[-1], "\n")

    if(n_iter > max_iter):
        print("L'algorithme n'a pas convergé.")

    file = filepath[:-4] + "_mini.txt"

    if(save):
        with open(file, 'w') as filout:
            filout.write("Step\tVpot\tGRMS\txO\tyO\tzO\txH1\tyH1\tzH1\txH2\tyH2\tzH2\n")
            for step in range(n_iter) :
                filout.write("{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\n".format(step,vpot[step],grms[step],coords_all[step][0],coords_all[step][1],coords_all[step][2],coords_all[step][3],coords_all[step][4],coords_all[step][5],coords_all[step][6],coords_all[step][7],coords_all[step][8]))
        filout.close()

    return coords_all[-1]



##############
#    MAIN    #
##############

if __name__ == "__main__":

    # Parsing des arguments
    args = sys.argv
    filepath = args[1]


    # Contrôles du fichier
    if os.path.isfile(filepath) != True :
        print("Le fichier spécifié n'existe pas.")
        sys.exit()
    if filepath[-4:] != ".pdb" :
        print("Le fichier doit être au format pdb.")
        sys.exit()

    save = True
    if '-s' not in args :
        save = False



    # Coordonnées de départ : [O, H1, H2]
    coords = extract_coords(filepath)
    print("Coordonnées de départ :\n", coords, end='\n\n')

    # Energie potentielle de départ
    epot = e_potential(coords)
    print("Energie potentielle de départ :\n", epot, end = '\n\n')

    # Gradient de départ
    grad = calc_gradient(coords)
    
    # GRMS de départ
    grms = np.linalg.norm(grad)
    print("GRMS de départ :\n", grms, end='\n\n')



    # Coordonnées après minimisation : [O, H1, H2]
    mini = steepest_descent(coords, 0.0002, 0.00001, 1000, save, filepath)
    print("Coordonnées après minimisation :\n", mini, end='\n\n')
