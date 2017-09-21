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
precision = 0.01
# f(x)
x = -m.pi
f_x = f(x)
sign = get_sign(f_x)
while x <= m.pi:
    # on calcule le prochain f(x) et son signe
    next_f_x = f(x + precision)
    next_sign = get_sign(next_f_x)
    # si on a changé de signe entre x et x+precision on a une racine
    if next_sign != sign:
        print "La racine de f est comprise entre {:.2f} et {:.2f}".format(
        x, x + precision)
    # on met à jour f(x) et son signe
    f_x = next_f_x
    sign = next_sign
    x += precision

print

# g(x)
x = -m.pi
g_x = g(x)
sign = get_sign(g_x)
while x <= m.pi:
    # on calcule le prochain g(x) et son signe
    next_g_x = g(x + precision)
    next_sign = get_sign(next_g_x)
    # si on a changé de signe entre x et x+precision on a une racine
    if next_sign != sign:
        print "La racine de g est comprise entre {:.2f} et {:.2f}".format(
        x, x + precision)
    # on met à jour g(x) et son signe
    g_x = next_g_x
    sign = next_sign
    x += precision
