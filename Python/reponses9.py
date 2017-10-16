#9.5.1
#avec python tutor


#9.5.2
#def calc_puissance(x, y):
#    return x**y

##programme principal
#for i in range(21):
#    res = calc_puissance(2, i)
#    print('2^{:>2d} = {:>7d}'.format(i, res))


#9.5.3

#methode 1
#def gen_pyramid(N):
#    pyr = ''
#    for i in range(N):
#        pyr += '{:^{largeur}}\n'.format('*'*(2*i+1), largeur=2*N+1)
#    return pyr
###Programme principal
#print('Nombre de ligne de la pyramide:  ', end='')
#x = input()
#try: 
#    int(float(x))
#    print(gen_pyramid(int(float(x))))
#except:
#    print('ERREUR : le nombre doit être un entier')

#methode 2
#import sys
#if len(sys.argv) != 2:
#    sys.exit('ERREUR : il faut exactement un argument')

#def gen_pyramid(N):
#    pyr = ''
#    for i in range(N):
#        pyr += '{:^{largeur}}\n'.format('*'*(2*i+1), largeur=2*N+1)
#    return pyr
#print(gen_pyramid(int(sys.argv[1])))



#9.5.4
#import time
##methode1
#begin = time.time()
#N = 10000
#for n in range(2, N+1):
#    flag = True
#    for div in range(2, n):
#        if n%div == 0:
#            flag = False
#    if flag:
#        None 
##        print(n)
#end = time.time()
#print('temps d\'execution: '+str(end-begin))

##methode2
#begin = time.time()
#N = 10000
#premiers = []
#for n in range(2, N+1):
#    flag = True
#    for prem in premiers:
#        if n%prem == 0:
#            flag = False
#            break
#    if flag:
#        premiers.append(n)
##        print(n)
#end = time.time()
#print('temps d\'execution: '+str(end-begin))

#fonction
#def is_prime(n):
#    premiers = []
#    for k in range(2, n+1):
#        flag = True
#        for prem in premiers:
#            if k%prem == 0:
#                flag = False
#                break
#        if flag:
#            premiers.append(k)
#    return flag

##programme principal
#N=10000
#for n in range(2, N+1):
#    if is_prime(n):
#        print('{:{width}d} est premier'.format(n, width=len(str(N))))
#    else:
#        print('{:{width}d} n\'est pas premier'.format(n, width=len(str(N))))



#9.5.5
#def complement(seq):
#    bases_comp = {'A':'T', 'T':'A', 'G':'C', 'C':'G'}
#    seq_comp = []
#    for base in seq:
#        seq_comp.append(bases_comp[base])
#    return seq_comp

##programme principal
#seq = ['A', 'T', 'C', 'G', 'A', 'T', 'C', 'G', 'A', 'T', 'C', 'G', 'C', 'T', 'G', 'C', 'T', 'A', 'G', 'C']
#print('brin direct        : 5\'-', end='')
#for base in seq:
#    print(base, end='')
#print('-3\'')
#print('brin complementaire: 3\'-', end='')
#for base in complement(seq):
#    print(base, end='')
#print('-5\'')



#9.5.6
#from math import sqrt

#def calc_distance3D(xyzA, xyzB):
#    x2 = (xyzA[0]-xyzB[0])**2
#    y2 = (xyzA[1]-xyzB[1])**2
#    z2 = (xyzA[2]-xyzB[2])**2
#    d = sqrt(x2+y2+z2)
#    return d

##programme principal
#A = (0,0,0)
#B = (1,1,1)
#print(calc_distance3D(A, B))



#9.5.7
#import random as rd
#from numpy import median, mean

#def gen_distrib(debut, fin, n):
#    nombres = []
#    for i in range(n):
##        nb = debut + fin*rd.random()
#        nb = rd.uniform(debut, fin)
#        nombres.append(nb)
#    return nombres

#def calc_stats(floats):
#    return [min(floats), max(floats), mean(floats), median(floats)] 
##programme principal
#N = 20
#for k in range(N+1):
#    d = gen_distrib(0, 100, 100)
#    s = calc_stats(d)
#    print('Liste {:>{width}d} : min = {:>7.4f} ; max = {:>7.4f} ; mediane = {:>7.4f} ; moyenne = {:>7.4f}'.format(k, s[0], s[1], s[3], s[2], width=len(str(N))))




##9.5.8
#import math

#def calc_distance2D(xyA, xyB):
#    x2 = (xyA[0]-xyB[0])**2
#    y2 = (xyA[1]-xyB[1])**2
#    d = math.sqrt(x2+y2)
#    return d

#def calc_dist2ori(list_x, list_y):
#    dist2ori = []
#    for i in range(len(list_x)):
#        d = calc_distance2D([list_x[i], list_y[i]], [0, 0])
#        dist2ori.append(d)
#    return dist2ori

##programme principal
#list_x = [x/10 for x in range(-31, 31)]
#list_y = [math.sin(x) for x in list_x]
#d2o = calc_dist2ori(list_x, list_y)

#with open ('sin2ori.dat', 'w') as filout:
#    for i in range(len(list_x)):
#        filout.write('{} {} \n'.format(list_x[i], d2o[i]))



#9.5.9
import math

def calc_aire(list_x, list_y):
    aire = 0
    for i in range(len(list_x)-1):
        h = list_x[i+1]-list_x[i]
        b = list_y[i]
        B = list_y[i+1]
        aire += ((B+b)*h)/2
    return aire

#programme principal
list_x = [x/100 for x in range(101)]
list_y = [x**2 for x in list_x]
print(calc_aire(list_x, list_y))














