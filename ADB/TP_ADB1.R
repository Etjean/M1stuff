#TP1 Analyse de Données Biologiques

#CHAPTER 2--------------------------------------------------------------------------------------
#lecture du jeu de données
pockets = read.table("descriptor_pocket.mat")

#suppression des lignes contenant des valeurs manquantes NA
print(dim(pockets))
print(is.na(pockets))
pockets = na.omit(pockets)
print(dim(pockets))

#ajout de la fréquence des différents types de residus
aromatic = apply(cbind(pockets$F, pockets$Y, pockets$H, pockets$W), 1, sum)
polar = apply(cbind(pockets$C, pockets$D, pockets$E, pockets$H, pockets$K, pockets$N, pockets$Q, pockets$R, pockets$S, pockets$T, pockets$W, pockets$Y), 1, sum)
aliphatic = apply(cbind(pockets$I, pockets$L, pockets$V), 1, sum)
charged = apply(cbind(pockets$D, pockets$E, pockets$R, pockets$K, pockets$H), 1, sum)
negative = apply(cbind(pockets$D, pockets$E), 1, sum)
positive = apply(cbind(pockets$R, pockets$K, pockets$H), 1, sum)
hydrophobic = apply(cbind(pockets$C, pockets$G, pockets$A, pockets$T, pockets$V, pockets$L, pockets$I, pockets$M, pockets$F, pockets$W, pockets$H, pockets$Y, pockets$K), 1, sum)
small = apply(cbind(pockets$C, pockets$G, pockets$A, pockets$T, pockets$V, pockets$S, pockets$D, pockets$N, pockets$P), 1, sum)
tiny = apply(cbind(pockets$A, pockets$C, pockets$G, pockets$S), 1, sum)
pockets = cbind(pockets, aromatic, polar, aliphatic, charged, negative, positive, hydrophobic, small, tiny)

print(pockets)
print(dim(pockets))     #37 descriptors


#mise de "drugg" à la fin du tableau
noms = names(pockets)
pockets = cbind(pockets[,1:27], pockets[,29:37], pockets[,28])
colnames(pockets)[37] = noms[28]


#PLOTS
boxplot(scale(pockets[,-37]), las=2)

#ma version
hist(pockets$polar[pockets$drugg == 1], freq=F, col = "green", xlim = c(0, 1))
hist(pockets$polar[pockets$drugg == 0], freq=F, col =rgb(1,0,0,0.5), add=T)

#version prof
par(mfrow = c(1, 2))
for (i in c(1:36))
    by(pockets[,i], pockets$drugg, hist, main = "un histogramme")

#ma version
for (i in 1:36){
    print(mean(pockets[,i][pockets$drugg == 1]))
    print(mean(pockets[,i][pockets$drugg == 0]))
    print(sd(pockets[,i][pockets$drugg == 1]))
    print(sd(pockets[,i][pockets$drugg == 0]))
}

#version prof
lapply(pockets, mean)  global
lapply(pockets, sd)
print(means <- aggregate(pockets[,-37], by=list(pockets$drugg), FUN = mean))
print(sds <- aggregate(pockets[,-37], by=list(pockets$drugg), FUN = mean))

#tests
pockets_pvalues = c()
for (i in 1:36){
# optionnel, il faudrait comparer les variances, comme condition d'application du Student
#    var.test(pockets[,i][pockets$drugg == 1], pockets[,i][pockets$drugg == 0])
    pvalue = t.test(pockets[,i][pockets$drugg == 1], pockets[,i][pockets$drugg == 0])$p.value
    pockets_pvalues = c(pockets_pvalues, pvalue)
}

print(pockets_pvalues)
# descripteurs pour lesquels la p-value est inférieure à 5%
print(names(pockets[which(pockets_pvalues < 0.05)]))

#correlation
print(drug.corr <- cor(pockets[,-37]))
library(corrplot)
corrplot(drug.corr)
plot(pockets$polar, pockets$hydrophobic)
plot(pockets$Real_volume, pockets$C_ATOM)



#CHAPTER 3--------------------------------------------------------------------------------------
#3.2.1
dist = dist(scale(pockets[,-37]))
tree = hclust(dist, method = "ward.D2")
plot(tree, hang=-1, labels = pockets$drugg)
rect.hclust(tree, k = 4, border = "red")

#3.2.2
kmeans(pockets[, -37], 2)














