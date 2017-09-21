# constante
TOUTES_LES_LETTRES = "".join([chr(i) for i in range(97,97+25)]) # "abcdefghijklmnopqrstuvwxyz"

def calc_composition(chaine):
    # enlever ponctuation + passer en minuscule
    chaine = chaine.replace(" ","").replace(".","").replace(",","").\
                    replace("'","").replace("\n","").replace(";","").\
                    replace("-","").replace("!","").lower()
    # compter les lettres
    dico={}
    for c in chaine:
        if c in dico:
           dico[c] += 1
        else:
           dico[c] = 1
    print dico
    # completer lettres manquantes et passer en frequence
    for l in TOUTES_LES_LETTRES:
        if l not in dico:
            dico[l] = 0.0
        else:
            dico[l] /= float(len(chaine))
    return dico

###
# main
###
with open("Perec.txt") as f:
    chaine_perec = f.read()
dico_perec = calc_composition(chaine_perec)

with open("Zola.txt") as f:
    chaine_zola = f.read()
dico_zola = calc_composition(chaine_zola)

# imprimer le resultat final
print "  %7s %7s" % ("Perec","Zola")
for l in TOUTES_LES_LETTRES:
    if l == "e":
        print "%s %7.3f %7.3f <---" % (l,dico_perec[l],dico_zola[l])
    else:
        print "%s %7.3f %7.3f" % (l,dico_perec[l],dico_zola[l])
