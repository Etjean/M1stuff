#7.6.1
#Il y a a la fois le retour a la ligne du fichier, et le retour a la ligne du print.
#with open('zoo.txt', 'r') as zoo:
#    for ligne in zoo:
#        print(ligne, end='')


#7.6.2
#animaux2 = ['poisson', 'abeille', 'chat']
#with open('zoo2.txt', 'w') as zoo2:
#    for ani in animaux2:
#        zoo2.write(ani + '\n')


#7.6.3
#with open ('first_helix_1tfe.txt', 'r') as filin:
#    lines = filin.readlines()    #1
##    lines = []                   #2
##    for line in filin:           #2
##        lines.append(line)       #2
#print(lines)

#with open('output.txt','w') as filout:
#    for line in lines:
#        filout.write(line)

#with open('output2.txt','w') as filout:
#    for line in lines:
#        filout.write(line[:-1] + '    line checked\n')


#7.6.4
import math

with open('spirale.dat', 'w') as filout:
    for theta in range(0, int(100*4*math.pi)):
            r = theta/2
            x = math.cos(theta/100)*r
            y = math.sin(theta/100)*r
            filout.write(str(x) + '    ' + str(y) + '\n')

















































