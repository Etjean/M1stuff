
iris

X=as.matrix(iris[,1:4])

plot(X[,1:2], col = as.integer(iris[,5]))

X = scale(X)
#mean(X[,1])=0
#mean(X[,2])=0
#mean(X[,3])=0
#mean(X[,4])=0
A = t(X)%*%X
print(eigen(A))
















