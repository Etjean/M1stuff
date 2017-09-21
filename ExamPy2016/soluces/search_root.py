# coding: utf-8

import math as m

def f(x):
    return .5 * m.sin(1.5*x - m.pi)

def g(x):
    return m.exp(1/(1.0+x**2)) - m.pi/2

def get_sign(x):
    if x >= 0:
        return 1
    else:
        return -1

###
# prog principal
###
# on definit la precision
precision = 0.01
# listes vides pour accumuler g(x) et g(x)
liste_f_x = []
liste_g_x = []
# boucle pour calculer f(x) et g(x) entre -pi et pi (on garde x et f(x), x et g(x))
x = -m.pi
while x <= m.pi:
    liste_f_x.append({'x': x, 'f(x)':f(x)})
    liste_g_x.append({'x': x, 'g(x)':g(x)})
    x += precision

# on se ballade sur f(x) et quand ça change de signe on a trouvé une racine
for i in range(len(liste_f_x) - 1):
    sign_i = get_sign(liste_f_x[i]['f(x)'])
    sign_ip1 = get_sign(liste_f_x[i+1]['f(x)'])
    if sign_i != sign_ip1:
        print "La racine de f est comprise entre {:.2f} et {:.2f}".format(
        liste_f_x[i]['x'], liste_f_x[i+1]['x'])

print

# on se ballade sur g(x) et quand ça change de signe on a trouvé une racine
for i in range(len(liste_g_x) - 1):
    sign_i = get_sign(liste_g_x[i]['g(x)'])
    sign_ip1 = get_sign(liste_g_x[i+1]['g(x)'])
    if sign_i != sign_ip1:
        print "La racine de g est comprise entre {:.2f} et {:.2f}".format(
        liste_g_x[i]['x'], liste_g_x[i+1]['x'])
