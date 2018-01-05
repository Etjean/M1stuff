#!/usr/bin/env python3
import numpy as np
import os
import sys

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


def extract_coords(filepath):
    """Retourne, sous forme d'un vecteur de taille 3*nombre_d'atomes, les coor-
    données xyz de tous les atomes du fichier PDB passé en argument.
    """
    coords = []
    with open(filepath, 'r') as filin:
        for line in filin:
            if line[0:6].strip() == 'ATOM':
                x = float(line[30:38].strip())
                y = float(line[38:46].strip())
                z = float(line[46:54].strip())
                coords += [x, y, z]
    if coords == [] :
        print("Erreur de lecture du fichier.")
        sys.exit()
    return np.array(coords)


def angle(vect1, vect2):
    """Retourne l'angle theta entre les vecteurs 1 et 2."""
    dot = np.dot(vect1, vect2)
    norm1 = np.linalg.norm(vect1)
    norm2 = np.linalg.norm(vect2)
    return np.arccos(dot/(norm1*norm2))


def e_bond(l):
    """Retourne l'énergie de liaison."""
    return (1/2)*K_BOND*(l-L_EQ)**2


def e_angle(th):
    """Retourne l'énergie d'angle."""
    return (1/2)*K_ANGLE*(th-TH_EQ)**2


def e_potential(coords):
    """Retourne l'énergie potentielle du système."""
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


def calc_gradient(coords):
    """Retourne le gradient de l'énergie potentielle (dérivées numériques)."""
    gradient = []
    for i in range(len(coords)):
        # Ajout d'un déplacement élémentaire DELTA à la coordonnée i
        coords_plus_delta = coords.copy()
        coords_plus_delta[i] += DELTA
        coords_less_delta = coords.copy()
        coords_less_delta[i] -= DELTA
        # Calcul du nombre dérivé
        deriv = (e_potential(coords_plus_delta) - e_potential(coords_less_delta)) / (2*DELTA)
        gradient.append(deriv)
    return np.array(gradient)


def line_search(coords, grad):
    """Renvoie le pas optimal pour la minimisation.
    Le pas est optimal par la méthode du nombre d'or.
    """
    # Nombre d'or :
    gold = (1+np.sqrt(5))/2
    # Initialisation : encadrement initial du minimum défini arbitrairement
    step_a = -0.1
    step_b = 0
    step_c = -gold*step_a
    epot_a = e_potential(coords - step_a*grad)
    epot_b = e_potential(coords - step_b*grad)
    epot_c = e_potential(coords - step_c*grad)
    # Initialisation : élargissement de l'encadrement initial si nécéssaire
    while epot_a < epot_b or epot_c < epot_b:
        step_a *= 10
        step_c *= 10
        epot_a = e_potential(coords - step_a*grad)
        epot_c = e_potential(coords - step_c*grad)
    # Réduction de l'encadrement par la méthode du nombre d'or (10 itérations)
    for _ in range(10):
        # Si l'intervalle entre b et c est le plus grand:
        if (step_c-step_b) >= (step_b-step_a):
            # Placement d'un quatrième point d
            step_d = (step_c + gold * step_b) / (gold + 1)
            epot_d = e_potential(coords - step_d * grad)
            # Définition du nouvel encadrement
            if epot_d <= epot_b:
                step_a = step_b
                step_b = step_d
            else:
                step_c = step_d
        # Sinon, l'intervalle entre a et b et le plus grand:
        else:
            # Placement d'un quatrième point d
            step_d = (step_a+gold*step_b)/(gold+1)
            epot_d = e_potential(coords - step_d*grad)
            # Définition du nouvel encadrement
            if epot_d <= epot_b:
                step_c = step_b
                step_b = step_d
            else:
                step_a = step_d
        # Actualisation des énergies potentielles
        epot_a = e_potential(coords - step_a*grad)
        epot_b = e_potential(coords - step_b*grad)
        epot_c = e_potential(coords - step_c*grad)
    return step_b


def steepest_descent(coords, threshold, max_iter, step=0.0002, ls=True, save=True, filepath='molecule.pdb'):
    """"Méthode de Steepest Descent."""
    n_iter = 0
    # Stockage des données de la minimisation dans des listes
    coords_all = [coords]
    grms = [np.linalg.norm(calc_gradient(coords))]
    vpot = [e_potential(coords)]
    while grms[-1] > threshold and n_iter < max_iter:
        # Calcul des nouvelles coordonnées
        coords = coords_all[-1]
        grad = calc_gradient(coords)
        if ls:
            step = line_search(coords, grad)
        coords = coords - step*grad
        # Remplissage des listes
        coords_all.append(coords)
        grms.append(np.linalg.norm(calc_gradient(coords)))
        vpot.append(e_potential(coords))
        n_iter += 1
    #Affichage du résultat
    print("STEEPEST DESCENT\nNombre d'itérations :", n_iter-1, "\nGRMS : ", grms[-1], "\nVpot : ", vpot[-1], "\n")
    if n_iter > max_iter:
        print("L'algorithme n'a pas convergé.")
    # Ecriture des données de la minimisation dans un fichier 'mini.txt'
    fileout = filepath[:-4] + "_mini.txt"
    if save:
        with open(fileout, 'w') as filout:
            filout.write("Step\tVpot\tGRMS\txO\tyO\tzO\txH1\tyH1\tzH1\txH2\tyH2\tzH2\n")
            for step in range(n_iter):
                filout.write("{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\n"
                             .format(step, vpot[step], grms[step],
                                     coords_all[step][0], coords_all[step][1],
                                     coords_all[step][2], coords_all[step][3],
                                     coords_all[step][4], coords_all[step][5],
                                     coords_all[step][6], coords_all[step][7],
                                     coords_all[step][8]))
    return coords


# programme principal
if __name__ == "__main__":
    #1
    print('Line-search ? y/n')
    ls = input()
    if ls == 'y':
        ls = True
    else:
        ls = False
        print('Vous avez choisi la méthode \"Pas constant\". Veuillez entrer la valeur:')
        step = float(input())
    #2
    print('')




    # Parsing des arguments
    args = sys.argv
    if len(args) == 1:
        print("Veuillez spécifier le chemin du fichier pdb à minimiser en argument.")
        sys.exit()
    filepath = args[1]
    # Contrôles du fichier
    if os.path.isfile(filepath) != True :
        print("Le fichier spécifié n'existe pas.")
        sys.exit()
    if filepath[-4:] != ".pdb" :
        print("Le fichier doit être au format pdb.")
        sys.exit()
    #Option de sauvegarde
    save = False
    if '-s' in args :
        save = True
    # Coordonnées de départ : [O, H1, H2]
    coords = extract_coords('water.pdb')
    print("Array des coordonnées de départ :\n", coords, end='\n\n')
    # Energie potentielle de départ
    epot = e_potential(coords)
    print("Energie potentielle de départ :\n", epot, end='\n\n')
    # Gradient de départ
    grad = calc_gradient(coords)
    print("Gradient de départ :\n", grad, end='\n\n')
    # GRMS de départ
    grms = np.linalg.norm(coords)
    print("GRMS de départ :\n", grms, end='\n\n')
    # Steepest descent
    mini = steepest_descent(coords, 0.00001, 1000, step=0.002, ls=ls, save=save, filepath=filepath)
    print("Vecteur des coordonnées après minimisation :\n", mini, end='\n\n')

