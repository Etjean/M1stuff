



def calc_composition(chaine):
    chaine = chaine.lower()
    freq = {}
    for car in chaine:
        if 97 <= ord(car) <= 122:
            if car not in freq:
                freq[car] = 1
            else:
                freq[car] += 1
    return freq





#programme principal
with open('fichiers_distribues/Perec.txt', 'r') as perec:
    comp_perec = calc_composition(perec.read())
with open('fichiers_distribues/Zola.txt', 'r') as zola:
    comp_zola = calc_composition(zola.read())

print(comp_perec)
print(comp_zola)













