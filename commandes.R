#TP1 de R

##exo1
#cos(25)
#cos(75)
#cos(90)
#print("un bon informaticien blablabla")
#nchar("un bon informaticien blablabla")

##exo2
#print(4850/26)
#print(round(4850/26,3))

##exo3
#print(pi)
#print(round(pi,3))
#print(round(pi,5))
#print(pi+12)
#pi = 9
#print(pi)

##exo4
#vec1 = c(1:12)
#vec1 = c(vec1, 16:18)
#print(vec1)
#print(vec2 <- seq(0, 5, 0.5))

##exo6
#print(vec3 <- seq(2, 50, 2))
#print(vec4 <- sort(rep(0:3, 3)))
#print(vec5 <- sort(rep(LETTERS, 1:26)))

##exo7
#print(vec6 <- paste("individu", 1:100, sep=""))

##exo8
#print(matIdentite <- diag(1, 10, 10))
#print(matAleatoire <- matrix(rnorm(100, 0, 5), 10, 10))

##exo9
#dateJour = date()
#m1 = 3
#m2 = "promotions assistent au cours de R du"
#print(paste(m1, m2, dateJour))

##exo10
#vecX = 1:20
#print(vecX[1:5]^2)
#print(sinusX <- sin(vecX))
#print(xNeg <- which(sinusX<0))
#print(length(xNeg))
#sinusX[xNeg] = 0
#print(sinusX)
#print(xEven <- sinusX[seq(2, length(sinusX), 2)])
#print(xOdd <- sinusX[seq(1, length(sinusX), 2)])

##exo11
#precip = data("precip")
#print(villes <- names(precip)) #70 villes
#print(precip[c("Philadelphia", "Columbia", "Baltimore", "Sacramento")])

##exo12
#x1 = rnorm(100, 0, 1)
#x2 = runif(100, 0, 10)
#print(x1)
#print(x2)
#m1 = cbind(x1[1:10], x2[91:100])
#print(m1)
#m2 = cbind(x1[c(16, 51, 79, 31, 27)], x2[c(30, 70, 12, 49, 45)])
#print(m2)
#print(m12 <- rbind(m1, m2)) #dim = 15, 2
#print(dim(m12))

##exo13
#for(i in 1:10){
#    print(i)
#}
#print(sumCumul <- sum(1:10))

##exo14
#print(matAlea <- matrix(rnorm(100, 0.2, 3.2), 10, 10), digits = 2)
#if(sum(matAlea) > 15){
#    print("la somme est supérieure à 15")
#}else{
#    print("la somme est n'est pas supérieure à 15")
#}

##exo15
#vecPasMultiples = c()
#for(i in 1:100){
#    if(i%%5 != 0){
#        vecPasMultiples = c(vecPasMultiples, i)
#    }
#}
#print(vecPasMultiples)

##exo16
#A = diag(2, 10, 10)
#for(i in 1:9){
#    A[i, i+1] = -1
#    A[i+1, i] = 1
#}
#print(A)

##exo17
#print(vecAlea <- rnorm(100, 4, 5), digits = 2)
#print(vecSup3 <- which(vecAlea > 3))
#print(valSomme <- sum(vecAlea[vecSup3]))
#if(valSomme > 400){
#    print("la somme est supérieure à 400")
#}else if(valSomme > 300){
#    print("la somme est supérieure à 300")
#}else if(valSomme > 200){
#    print("la somme est supérieure à 200")
#}

#exo18
#matrice = matrix(0, 10, 10)
#for(j in 1:10){
#    col = rnorm(10, j, j)
#    matrice[,j] = col
#}
#print(matrice, digits=2)
#print(sum(matrice>0))
#print(mat_pos <- matrice*(matrice>0), digits=2)
#print(apply(mat_pos, 1, sum), digits=2)
#print(apply(mat_pos, 2, sum), digits=2)

##exo19
#print(D <- WorldPhones)
#print(data.class(D))
#print(years <- apply(D, 1, sum))
#print(conts <- apply(D, 2, sum))
#print(names(years[which(years == max(years))]))
#print(names(conts[which(conts == max(conts))]))
#print(sum(conts > 20000))
#print(sum(conts > 50000))
#print(sum(conts > 200000))

#exo20
#print(sample(c("pile", "face"), 100, replace=TRUE))
#print(vecSampleBias <- sample(c("pile", "face"), 100, replace=TRUE,prob=c(0.3, 0.7)))
#print(sum(vecSampleBias=="pile")/100)

#exo21
#n = 257
#m = 312
#tailleF = floor(rnorm(n, 165, 6))
#tailleH = floor(rnorm(m, 175, 7))
#poidsF = floor(rnorm(n, 60, 2))
#poidsH = floor(rnorm(m, 75, 4))
#print(tailleF)
#combineData = cbind(rbind(cbind(tailleF, poidsF), cbind(tailleH, poidsH)), c(rep("F", n), rep("H", m)))
#colnames(combineData) = c("Taille", "Poids", "Sexe")
#print(combineData)

#print(combineData["Sexe"=="F"])
#print(combineData["Sexe"=="F"])
#combineData = data.frame(combineData)
#combineData$Sexe == "F"



#exo24
#somme = function(x, y){
#    return (x+y)
#}
#print(somme(3, 4))

##exo25
#calculTarif = function(age){
#    if(age<=12){
#        print("demi-tarif")
#    }else if(age>60){
#        print("tarif senior")
#    }else{
#        print("toi tu raques")
#    }
#}
#calculTarif(7856)

#exo26
#resMention = function(note){
#    if (note<10){
#        print("pas admis")
#    }else if (note>=10 & note<12){
#        print("sans mention")
#    }else if (note>=12 & note<14){
#        print("mention assez bien")
#    }else if (note>=14 & note<16){
#        print("mention bien")
#    }else if (note>=16 & note<=20){
#        print("mention très bien")
#    }else{
#        print("note invalide")
#    }
#}
#resMention(9)
#resMention(11)
#resMention(13)
#resMention(16)
#resMention(25)

#exo27
#formule = function(x){
#    y = 4*x^3/18+8.34*x/5
#    return (y)
#}
#print(formule(2))
#print(formule(-4))
#print(formule(18))
#print(vecY <- formule(c(15, 89, 56, 78, 152, 66, 48, 77, 2, 96)), digits=2)

##exo28
#premier = function(n){
#    flag = TRUE
#    for (i in 2:(n-1)){
#        if (n%%i == 0){
#            flag = FALSE
#        }
#    }
#    if (n==2){
#        flag = TRUE
#    }
#    return (flag)
#}
#print(premier(11))
#print(premier(12))

#vecNbrPrem = c()
#for(j in 2:100){
#    vecNbrPrem = c(vecNbrPrem, j[premier(j)])
#}
#print(vecNbrPrem)


##exo29
#ispalindrome = function(mot){


##exo36
## objet de classe data.frame
## ozone, solar.R, wind, temp, month, day
## relevés sur 5 mois (Mai à Septembre inclus)
#print(sum(is.na(airquality$Ozone)))
#print(mean(airquality$Ozone[which(airquality$Month==5)], na.rm=T))
#print(var(airquality$Ozone[which(airquality$Month==5)], na.rm=T))

##exo37&38
#pdf("SIN_COS.pdf")
#plot(sin(seq(-pi, pi, 0.1)), xlab = 'x', ylab = 'y', main = 'SINUS et COSINUS entre -Pi et +Pi', type = 'l')
#lines(cos(seq(-pi, pi, 0.1)))
#dev.off()

#exo39
#N = rnorm(1000, 0, 1)
#print(mean(N))
#print(var(N))
#print(sd(N))
#histo = hist(N, prob=T)
#ploto = histo$mids
#par(new=T)
#plot(dnorm(ploto), type = 'l')

#exo40
#seq = sample(c('A', 'T', 'G', 'C'), 100, replace=T)
#write.table(seq, file = "sequence_R.txt")

#exo43
#N = rnorm(100, 10, 5)
#hist(N, breaks=seq(min(N),max(N),(max(N)-min(N))/10)) 

#exo44
plot(c(1,1.7,2.3,3), c(2,0.5,0.5,2), cex=c(20, 20, 20, 20), pch=c(25, 15, 15, 25), xlim=c(0.5,4), ylim=c(0,3), col=c(1, 38, 38, 1))
par(bg = 'black')
























