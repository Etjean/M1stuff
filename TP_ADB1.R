#TP1 Analyse de Données Biologiques
#lecture du jeu de données
pockets = read.table("descriptor_pocket.mat")

#suppression des lignes contenant des valeurs manquantes NA
print(dim(pockets))
print(is.na(pockets))
pockets = na.omit(pockets)
print(dim(pockets))

#ajout de la fréquence des différents types de residus
aromatic = apply(cbind(pockets$F, pockets$Y, pockets$H, pockets$W), 1, sum)
pockets = cbind(pockets, aromatic)

polar = apply(cbind(pockets$C, pockets$D, pockets$E, pockets$H, pockets$K, pockets$N, pockets$Q, pockets$R, pockets$S, pockets$T, pockets$W, pockets$Y), 1, sum)
pockets = cbind(pockets, polar)

aliphatic = apply(cbind(pockets$I, pockets$L, pockets$V), 1, sum)
pockets = cbind(pockets, aliphatic)

charged = apply(cbind(pockets$D, pockets$E, pockets$R, pockets$K, pockets$H), 1, sum)
pockets = cbind(pockets, charged)

negative = apply(cbind(pockets$D, pockets$E), 1, sum)
pockets = cbind(pockets, negative)

positive = apply(cbind(pockets$R, pockets$K, pockets$H), 1, sum)
pockets = cbind(pockets, positive)

hydrophobic = apply(cbind(pockets$C, pockets$G, pockets$A, pockets$T, pockets$V, pockets$L, pockets$I, pockets$M, pockets$F, pockets$W, pockets$H, pockets$Y, pockets$K), 1, sum)
pockets = cbind(pockets, hydrophobic)

small = apply(cbind(pockets$C, pockets$G, pockets$A, pockets$T, pockets$V, pockets$S, pockets$D, pockets$N, pockets$P), 1, sum)
pockets = cbind(pockets, small)

tiny = apply(cbind(pockets$A, pockets$C, pockets$G, pockets$S), 1, sum)
pockets = cbind(pockets, tiny)

print(pockets)
print(dim(pockets))     #37 descriptors


#mise de "drugg" à la fin du tableau
noms = names(pockets)
pockets = cbind(pockets[,1:27], pockets[,29:37], pockets[,28])
colnames(pockets)[37] = noms[28]


#boxplot
#boxplot(pockets[,-37])
hist(pockets$polar[pockets$drugg == 1], freq=F, col = "green", xlim = c(0, 1))
hist(pockets$polar[pockets$drugg == 0], freq=F, col =rgb(1,0,0,0.5), add=T)















