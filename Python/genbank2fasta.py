#!/usr/bin/env python3

import sys
import re
import os


def get_stdin():
    """Renvoie le nom du fichier passé en argument en entrée standard\
    Gère les erreurs."""
    if len(sys.argv) != 2:
        sys.exit("ERREUR : il faut exactement un argument (Le chemin d'accès d'un fichier genbank).")
    else:
        if os.path.exists(sys.argv[1]):
            return sys.argv[1]
        else:
            sys.exit("ERREUR : Ce fichier n'existe pas. Veuillez entrer le chemin d'accès d'un fichier genbank.")


def lit_fichier(fichier):
    """Renvoie une liste contenant les lignes du fichier"""
    with open(fichier, 'r') as filin:
        lignes = filin.readlines()
    return lignes


def extrait_organisme(lignes):
    for ligne in lignes:
        if re.search('ORGANISM', ligne):
            ligne_orga = ligne.replace('ORGANISM', '').strip()
    return ligne_orga


def recherche_genes(lignes):
    """Renvoie une liste contenant les positions des genes sous forme de tuples:\
       (position_première_base, position_dernière_base, 'sens' ou 'antisens')"""
    regex_sens = re.compile('gene *<?([0-9]+)\.\.>?([0-9]+)')
    regex_antisens = re.compile('gene *complement\(<?([0-9]+)\.\.>?([0-9]+)\)')
    genes = []
    for ligne in lignes:
        result_sens = regex_sens.search(ligne)
        result_antisens = regex_antisens.search(ligne)
        if result_sens:
#            print('S '+ligne, end='')
            genes.append((int(result_sens.group(1)), int(result_sens.group(2)),\
            'sens'))
        elif result_antisens:
#            print('AS'+ligne, end='')
            genes.append((int(result_antisens.group(1)), int(result_antisens.group(2)),\
            'antisens'))
    return genes


def extrait_sequence(lignes):
    """Renvoie la séquence sous forme de chaine de caractères"""
    flag = False
    seq = ''
    for ligne in lignes:
        if re.search('ORIGIN', ligne):
            flag = True
        elif re.search('//', ligne):
            flag = False
        elif flag == True and not re.search('ORIGIN', ligne):
            seq += ligne[10:-1].replace(' ', '')
    return seq


def construit_comp_inverse(seq):
    """Renvoie la séquence complémentaire sous forme de chaine de caratctères"""
    inverseur = {'a':'t', 't':'a', 'g':'c', 'c':'g'}
    seqinv = ''
    seq = seq.lower()
    for base in seq:
        seqinv += inverseur[base]
    return seqinv


def ecrit_fasta(fichier, comment, seq):
    """Ecrit un fichier fasta dans le répertoire courant"""
    filout = open(fichier, 'w')
    i = 0
    while i < len(comment):
        filout.write(comment[i:i+80]+'\n')
        i += 80
    j = 0
    while j < len(seq):
        filout.write(seq[j:j+80]+'\n')
        j += 80
    filout.close()


def extrait_genes(genes, seq, orga):
    """Ecrit un fichier fasta pour chaque gene de la séquence.\
       Affiche les numéros des gènes et les fichiers fasta créés."""
    for i, gene in enumerate(genes):
        deb = gene[0]
        fin = gene[1]
        s_or_as = gene[2]
        num = i+1
        nom_fasta = './GenBank2Fasta/gene_{}.fasta'.format(num)
        comment_fasta = '>{}|{}|{}|{}|{}'.format(orga, num, deb, fin, s_or_as)
        print('Gène numéro {:>3d} | Nom du fasta: {} | {}'.format(num, nom_fasta, s_or_as))
        if s_or_as == 'sens':
            seq_gene = seq[deb:fin+1]
            ecrit_fasta(nom_fasta, comment_fasta, seq_gene)
        elif s_or_as == 'antisens':
            seq_gene = construit_comp_inverse(seq[deb:fin+1])
            ecrit_fasta(nom_fasta, comment_fasta, seq_gene)




#programme principal
if __name__ == "__main__":

    #0
    fichier = get_stdin()

    #1
    lignes = lit_fichier(fichier)
    print('Nombre de lignes du fichier    = '+str(len(lignes)))

    #2
    orga = extrait_organisme(lignes)
    print("Nom de l'organisme             = "+orga)

    #3
    genes = recherche_genes(lignes)
    print('Nombre total de gènes          = '+str(len(genes)))
    print('Nombre de gènes SENS           = '+str(len(\
    [genes[i] for i,g in enumerate(genes) if genes[i][2]=='sens'])))
    print('Nombre de gènes ANTISENS       = '+str(len(\
    [genes[i] for i,g in enumerate(genes) if genes[i][2]=='antisens'])))

    #4
    seq = extrait_sequence(lignes)
    print('Nombre de bases de la séquence = '+str(len(seq)))

    #5
    seqinv = construit_comp_inverse(seq)

    #6
    #commentaire = ">Ce fichier fasta est un test dans le cadre d'un entrainement en vue d'une évalutation sur machine de ma connaissance du langage de programmation python. J'ai donc créé ce commentaire afin de tester la fonction associée à l'écriture de ce fasta. Si tout va bien, les lignes de ce commentaire ne devraient pas dépasser 80 caractères."
    #ecrit_fasta('test.fasta', commentaire, seq)

    #7
    extrait_genes(genes, seq, orga)
























