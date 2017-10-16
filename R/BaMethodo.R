
# GEOMETRIE DES PROTEINES ----------------------------------------------------------------------------------------

#extraction des données
data = read.table("helix_phosph_layer.pdb")
X = as.matrix(data[,6:8])
library(rgl)
Xhelix = X[1:19,]
Xmemb = X[-(1:19),]

#calcul de l'axe de l'hélice
Xhelix = scale(Xhelix, scale=FALSE)
Ahelix = t(Xhelix)%*%Xhelix
Whelix = eigen(Ahelix)$vectors
w1helix = Whelix[,1]
w2helix = Whelix[,2]
axe = eigen(Ahelix)$vectors[,1]

#calcul de la normale à la membrane
Xmemb = scale(Xmemb, scale=FALSE)
Amemb = t(Xmemb)%*%Xmemb
Wmemb = eigen(Amemb)$vectors
w1memb <- Wmemb[,3]
norm = eigen(Amemb)$vectors[,3]

#calcul de l'angle
print(paste("Angle entre l'axe de l'hélice & la normale à la membrane (Radians) = ", angle_rad <- acos(axe%*%norm)))
print(paste("Angle entre l'axe de l'hélice & la normale à la membrane (Degrés)  = ", angle_deg <- angle_rad*180/pi))

#PLOTS
#plot de la membrane & de sa normale
plot3d(Xmemb, col="red", aspect = FALSE)
segments3d(c(0, norm[1]*20), c(0, norm[2]*20), c(0, norm[3]*20), col="orange")
#plot de l'hélice & de son axe
lines3d(Xhelix, col="blue")
segments3d(c(0, axe[1]*20), c(0, axe[2]*20), c(0, axe[3]*20), col = "green")




# COURBES ROC ------------------------------------------------------------------------------------------------------

#extraction des données
fish1 = read.table("size1.dat", header = T)
fish2 = read.table("size2.dat", header = T)


#calcul des spécificités & sensibilités
sensz1 = c()
specz1 = c()
sensz2 = c()
specz2 = c()
for (SEUIL in seq(0, max(c(fish2$size, fish1$size)), 0.01)){
    #séparation en groupes en fonction de la taille seuil
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

#fonction de calcul de l'intégale par la méthode des trapezes
trapeze = function(specz, sensz){
    x = 1-specz
    y = sensz
    integrale = 0
    for (i in 1:(length(x)-1)){
        integrale = integrale + (y[i]+y[i+1])*(abs(x[i]-x[i+1]))/2
    }
    return(integrale)
}

print(paste("AUC pour la population de jeunes flétans  = ", trapeze(specz1, sensz1)))
print(paste("AUC pour la population de flétans adultes = ", trapeze(specz2, sensz2)))


#PLOTS
plot(1-specz1, sensz1, ylim=range(c(sensz1, sensz2)), "l", xlab = "spécificité", ylab = "sensibilité", col = "orange", main="Courbes ROC de deux populations de flétans: sexe en fonction de la taille")
par(new = TRUE)
plot(1-specz2, sensz2, ylim=range(c(sensz1, sensz2)), "l", axes = FALSE, xlab = "", ylab = "", col = "red")



























