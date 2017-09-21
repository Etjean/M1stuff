#10.6.1
#animaux = ['girafe', 'tigre', 'singe', 'souris']
#taille = 0
#for ani in animaux:
#    print(ani)
#    print('taille = '+str(len(ani))+' caractères')

#10.6.2
#def calc_composition(seq):
#    l = len(seq)
#    fA = seq.count('A')/l
#    fT = seq.count('T')/l
#    fG = seq.count('G')/l
#    fC = seq.count('C')/l
#    return [fA, fT, fG, fC]

##programme principal
#seq = 'ATATACGGAATCGGCTGTTGCCTGCGTAGTAGCGT'
#print(calc_composition(seq))

#10.6.4
#def hamming(seq1, seq2):
#    d = 0
#    for i in range(len(seq1)):
#        if seq1[i] != seq2[i]:
#            d += 1
#    return d

##prog principal
#prot1 = 'AGWPSGGASAGLAIL'
#prot2 = 'IGWPSAGASAGLWIL'
#dna1 = 'ATTCATACGTTACGATT'
#dna2 = 'ATACTTACGTAACCATT'
#print(hamming(prot1, prot2))  # d=3
#print(hamming(dna1, dna2))    # d=4


##10.6.5
#def palindrome(string):
#    string2 = string.replace(' ', '')
#    string2 = string2.lower()
#    if string == string[::-1]:
#        print(string + ' est un palindrome')
#    else:
#        print(string + ' n\'est pas un palindrome')

##programme principal
#palindrome('Radar')
#palindrome('Never odd or even')
#palindrome('Karine alla en Iran')
#palindrome('Un roc si biscornu')


#10.6.6
#def composable(mot, lettres):
#    flag = True
#    for abc in mot:
#        if lettres.find(abc) == -1:
#            flag = False
#            break
#        else:
#            lettres.replace(abc, '*', 1)
#    if flag:
#        print('le mot "{}" est composable à partir de "{}"'.format(mot, lettres))
#    else:
#        print('le mot "{}" n\'est pas composable à partir de "{}"'.format(mot, lettres))

##prog principal
#mot = 'groscaca'
#lettres = 'ljfclawkdjfosrac'
#composable(mot, lettres)



#10.6.7
#def get_alphabet():
#    alphabeee = ''
#    for i in range (97, 123):
#        alphabeee += chr(i)
#    return alphabeee


#def pangramme(phrase_ori):
#    phrase = phrase_ori.lower()
#    flag = True
#    for lettre in get_alphabet():
#        if phrase.find(lettre) == -1:
#            flag = False
#            break
#    if flag:
#        print('"{}" est un pangramme'.format(phrase_ori))
#    else:
#        print('"{}" n\'est pas un pangramme'.format(phrase_ori))

#pangramme('Portez ce vieux whisky au juge blond qui fume')
#pangramme('Monsieur Jack vous dactylographiez bien mieux que votre ami Wolf')
#pangramme('Buvez de ce whisk que le patron juge fameux')


#10.6.8
def trouve_calpha(nom_fichier):
    lignes_calpha = []
    with open (nom_fichier, 'r') as filin:
        for line in filin:
            if line[0:6].strip() == 'ATOM' and line[12:16].strip() == 'CA':
                lignes_calpha.append(line)
    return lignes_calpha

if __name__ == "__main__":
    #programme principal
    print(trouve_calpha('1BTA.pdb')[0], end='')
    print(trouve_calpha('1BTA.pdb')[1], end='')
































