
iris

#X=as.matrix(iris[,1:4])

##plot(X[,1:2], col = as.integer(iris[,5]))

#X = scale(X)
##mean(X[,1])=0
##mean(X[,2])=0
##mean(X[,3])=0
##mean(X[,4])=0
#A = t(X)%*%X

#print(A)
#print(W <- eigen(A)$vectors)
#print(w1 <- W[,1])
#print(w2 <- W[,2])

#x = X%*%w1
#y = X%*%w2

#plot(x, y, col=as.integer(iris[,5]))

#-----------------------------------------------------

data = read.table("helix_phosph_layer.pdb")
X = as.matrix(data[,6:8])
library(rgl)
#plot3d(X)
Xhelix = X[1:19,]
Xmemb = X[-(1:19),]

#calcul de l'axe de l'hélice
Xhelix = scale(Xhelix, scale=FALSE)
Ahelix = t(Xhelix)%*%Xhelix
print(eigen(Ahelix))
Whelix = eigen(Ahelix)$vectors
w1helix = Whelix[,1]
w2helix = Whelix[,2]
axe = eigen(Ahelix)$vectors[,1]

#calcul de la normale à la membrane
Xmemb = scale(Xmemb, scale=FALSE)
Amemb = t(Xmemb)%*%Xmemb
print(eigen(Amemb))
Wmemb = eigen(Amemb)$vectors
w1memb <- Wmemb[,3]
norm = eigen(Amemb)$vectors[,3]


#PLOTS
#plot de la membrane & de sa normale
plot3d(Xmemb, col="red", aspect = FALSE)
segments3d(c(0, norm[1]), c(0, norm[2]), c(0, norm[3]), col="orange")
#plot de l'hélice & de son axe
lines3d(Xhelix, col="blue")
segments3d(c(0, axe[1]), c(0, axe[2]), c(0, axe[3]), col = "green")

#calcul de l'angle
print(angle_rad <- acos(axe%*%norm))
print(angle_deg <- angle_rad*180/piq)

























