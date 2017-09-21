#5.4.1
#orgs = ['vache', 'souris', 'levure', 'bacterie']
#for org in orgs:
#    print (org)
#for i in range(4):
#    print(orgs[i])
#i=0
#while i <= 3:
#    print(orgs[i])
#    i+=1#


#5.4.2
#semaine = ['lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi', 'dimanche']
#for i in range(len(semaine)-2):
#    print(semaine[i])
#i=-2
#while i < 0:
#    print(semaine[i])
#    i+=1


#5.4.3
#for i in range(1, 11):
#    print(i, end = " ")
#print('\n')


#5.4.4
#impairs = list(range(1,22,2))
#print(impairs)
#pairs = []
#for imp in impairs:
#    pair = imp + 1
#    pairs.append(pair)
#print(pairs)


#5.4.5
#notes = [14, 9, 6, 8, 12]
#moy = sum(notes)/len(notes)
#print('{:.2f}'.format(moy))


#5.4.6
#X = list(range(11))
#for i in range(len(X)-1):
#    y = X[i]*X[i+1]
#    print(y)


#5.4.7
#for i in range(10):
#    print('*'*i)


#5.4.8
#taille = 10
#for i in range(taille):
#    print('*'*(taille-i))


#5.4.9
#for i in range(10):
#    print('{:>10s}'.format('*'*i))


#5.4.10
#for i in range(10):
#    print('{:^21s}'.format('*'*(2*i+1)))

#methode2
#N = 10
#for i in range(N):
#    print('{:^{largeur}}'.format('*'*(2*i+1), largeur=2*N+1))

#bonus 1
#def gen_pyramid(N):
#    pyr = ''
#    for i in range(N):
#        pyr += '{:^{largeur}}\n'.format('*'*(2*i+1), largeur=2*N+1)
#    return pyr
#print(gen_pyramid(30))

#bonus 2
#def gen_pyramid(N):
#    pyr = ''
#    for i in range(N):
#        pyr += '{:^{largeur}}\n'.format('*'*(2*i+1), largeur=2*N+1)
#    return pyr
#print('largeur de la pyramide:  ', end='')
#x = input()
#print(gen_pyramid(int(x)))

#bonus 3
import sys
if len(sys.argv) != 2:
    sys.exit('ERREUR : il faut exactement un argument')

def gen_pyramid(N):
    pyr = ''
    for i in range(N):
        pyr += '{:^{largeur}}\n'.format('*'*(2*i+1), largeur=2*N+1)
    return pyr

print(gen_pyramid(int(sys.argv[1])))









#5.4.11
#taillemat = 10
#print('ligne', 'colonne')
#for i in range(1,taillemat+1):
#    for j in range(1,taillemat+1):
#        print('{:>4d}  {:>4d}'.format(i, j))


#5.4.12
#taillemat = 4
#print('ligne', 'colonne')
#for i in range(1,taillemat+1):
#    for j in range(1,taillemat+1):
#        if j>i:
#            print('{:>4d}  {:>4d}'.format(i, j))
















































