#exo1------------------------------------------------

#x = seq(-3, 3, 0.01)
#y = x^2 + x + 1




##tangente en x=1
## y = f(1) + f'(1)*(x-1)
#y1 = 3*x

##tangente en x=2
## y = f(2) + f'(2)*(x-2)
#y2 = 5*x - 3


##plot(x, y, "l")
#curve(x^2 + x + 1, from=-3, to=3)
#abline(b = 3, a = 0)
#abline(b = 5, a = -3)


#exo2------------------------------------------------



#tangente en x=1
#y = f(1) + f'(1)*(x-1)
#y = log(1) + x - 1

#curve(log(x), from=0, to=20)
##abline(b = 1, a = log(1)-1)

##DL1 en x=1
##ln(1+x) = x - x^2/2
#curve((x-1)-(x-1)^2/2, from =0, to =20, add = T)

##DL2 en x=1
##ln(x) = (x-1) - (x-1)^2/2 + (x-1)^3/3
#curve((x-1) - (x-1)^2/2 + (x-1)^3/3, from =0, to =20, add = T)


#################

##f(x) = exp(x)
##tangente en x=1
##y = f(1) + f'(1)*(x-1)
##y = exp(1)*x

#curve(exp(x), from=-5, to=5)
#abline(b = exp(1))

###DL1 en x=1
###exp(x) = 1 + x
#curve(1 + x, from =-2, to =2, add = T, col=2)

###DL2 en x=1
###exp(x) = 1 + x + x^2/2
#curve(1 + x + x^2/2, from =-2, to =25, add = T, col = 3)

#################

##f(x) = cos(x)
##tangente en x=1
##y = f(1) + f'(1)*(x-1)
##y = -sin(1)*x +sin(1)+cos(1)

#curve(cos(x), from=-5, to=5)
#abline(b = -sin(1), a = sin(1)+cos(1))

###DL1 en x=1
###f(x) = f(x0) + f'(x0)*(x-x0) + f''(x0)/2!*(x-x0)^2
#curve(cos(1) -sin(1)*(x-1), from =-5, to =5, add = T, col=2)

###DL2 en x=1
###exp(x) = 1 + x + x^2/2
#curve(cos(1) - sin(1)*(x-1) - cos(1)/2*(x-1)**2, from =-5, to =5, add = T, col = 3)


#exo3--------------------------------------------------


#library(rgl)
##f(x, y) = 2x**2 + y**2

#x = seq(-4, 4, 0.1)
#y = seq(-4, 4, 0.1)
#f <- function(x, y){2*x**2 + y**2}
#z = outer(x, y, f)
#persp3d(x, y, z, col = "pink", main="arrows(.)")

##df/dx (x, y) = 4x
##df/dy (x, y) = 2y

#xgradM = 4*0.5
#ygradM = 2*0.5


##########################


#library(rgl)
##f(x, y) = 2x**2 - y**2

#x = seq(-5, 5, 0.1)
#y = seq(-5, 5, 0.1)
#f <- function(x, y){2*x**2 - y**2}
#z = outer(x, y, f)

##df/dx (x, y) = 4x
##df/dy (x, y) = -2y
#xgradM = 4*0.5
#ygradM = -2*0.5


##persp3d(x, y, z, col = "pink", main="arrows(.)")
#contour(x, y, z, asp=1)
#arrows(0.5, 0.5, 0.5+xgradM, 0.5+ygradM, col = "blue")
#contour(x, y, z, levels = f(0.5, 0.5), col="orange", add=T)



#exo4-----------------------------------------
#0 = f(x0) - fp(x0)(x-x0)

##Algo de newton
#newton <- function(f, fp, x0, eps, maxiter){
#    i = 1
#    while (abs(f(x0)) > eps){
#        if (i < maxiter){
#            x0 = x0 - f(x0)/fp(x0)
#            i = i+1
#        }
#        else{
#            print("Ca diverge. Veuillez changer de x0")
#            break
#        }
#    }
#    print(paste("Racine de f         = ", x0))
#    print(paste("Valeur de f(racine) = ", f(x0)))
#    return(x0)
#}

##définition de f
#f <- function(x){
##    return(x+cos(x))
##    return(log(1+x)-2)
#    return(1/(1+x))
#}

##définition de la dérivée de f
#fp <- function(x){
##    return(1-sin(x))
##    return(1/(1+x))
#    return(-1/((1+x)**2))
#}


##PROGRAMME PRINCIPAL
#newton(f, fp, 1, 0.00001, 50)
##racine = -0.739
##racine = 6.389
##racine = +infini    (pas de racine, y=0 est asymptote)



#exo5--------------------------------------------

#calcul de l'integrale par la methode des trapèzes
trapezes = function(f, inf, sup, pas){
    integrale = 0
    for (i in seq(inf, sup-pas, pas)){
        integrale = integrale + (f(i+pas)+f(i))*pas/2
    }
    print(paste("intégrale par la méthode des trapèzes = ", integrale))
    return(integrale)
}


#calcul de l'integrale par la methode de Simpson
simpson = function(f, inf, sup, pas){
    integrale = 0
    for (i in seq(inf, sup-pas, pas)){
        integrale = integrale + (pas/6)*(f(i) + 4*f((i+i+pas)/2) + f(i+pas))
    }
    print(paste("intégrale par la méthode de Simpson   = ", integrale))
    return(integrale)
}



#definition de f
f = function(x){
    return(1/sqrt(2*pi)*exp(-((x-1)**2)/2))
#    return(x**2)
}

##PROGRAMME PRINCIPAL
#trapezes(f, -10, 10, 1)
##l'intégrale vaut 1
#simpson(f, -10, 10, 1)
##l'intégrale vaut 1
#print(paste("intégrale de N(1, 1) grace a pnorm    = ", pnorm(10, 1, 1)))


#Exercice Courbe ROC----------------------------------------




#   \vérité      T       F
#test\

#Positif         TP     FP

#Negatif         FN     TN


#sensibilité du test
#sens = prob(P | T) = TP/(TP+FN)
#spécificité du test
#spec = prob(N | F) = TN/(TN+FP)

#graph([sens] en fonction de [(1-spec)])
#la courbe ROC la plus haute est celle qui correspond au meilleur test

#UNE courbe ROC contient TOUS les seuils possibles
#La droite entre 0 et 1 correspond à la courbe ROC si on n'utilise aucune méthode (tirage au hasard, et décider male ou femelle). Son AUC vaut 0.5


#AUC = Area Under Curve

fish1 = read.table("size1.dat", header = T)
fish2 = read.table("size2.dat", header = T)



sensz1 = c()
specz1 = c()
sensz2 = c()
specz2 = c()
seuilz = seq(0, max(c(fish2$size, fish1$size)), 0.01)
for (SEUIL in seuilz){
    #seuils
    upsize1 = fish1$size[which(fish1$size >= SEUIL)]
    upsex1 = fish1$sex[which(fish1$size >= SEUIL)]
    dnsize1 = fish1$size[which(fish1$size < SEUIL)]
    dnsex1 = fish1$sex[which(fish1$size < SEUIL)]

    upsize2 = fish2$size[which(fish2$size >= SEUIL)]
    upsex2 = fish2$sex[which(fish2$size >= SEUIL)]
    dnsize2 = fish2$size[which(fish2$size < SEUIL)]
    dnsex2 = fish2$sex[which(fish2$size < SEUIL)]


    #Sensibilité
    TP1 = length(which(upsex1 == "M"))
    T1 = length(which(fish1$sex == "M"))
    sens1 = TP1/T1
    sensz1 = c(sensz1, sens1)

    TP2 = length(which(upsex2 == "M"))
    T2 = length(which(fish2$sex == "M"))
    sens2 = TP2/T2
    sensz2 = c(sensz2, sens2)

    #Spécificité
    TN1 = length(which(dnsex1 == "F"))
    F1 = length(which(fish1$sex == "F"))
    spec1 = TN1/F1
    specz1 = c(specz1, spec1)

    TN2 = length(which(dnsex2 == "F"))
    F2 = length(which(fish2$sex == "F"))
    spec2 = TN2/F2
    specz2 = c(specz2, spec2)
}



# plot(1-specz1, sensz1, ylim=range(c(sensz1, sensz2)), "l", xlab = "spécificité", ylab = "sensibilité", col = "orange", main="Courbes ROC de deux populations de flétans: sexe en fonction de la taille")
# par(new = TRUE)
# plot(1-specz2, sensz2, ylim=range(c(sensz1, sensz2)), "l", axes = FALSE, xlab = "", ylab = "", col = "red")


trapeze = function(specz, sensz){
    sensz = 1-sensz
    integrale = 0
    for (i in range(length(specz)-1)){
        integrale = integrale + (sensz[i]+sensz[i+1])*(abs(specz[i]-specz[i+1]))/2
    }
    return(integrale)
}

print(specz1)
print(1-sensz1)








