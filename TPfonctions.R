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


library(rgl)
#f(x, y) = 2x**2 - y**2

x = seq(-5, 5, 0.1)
y = seq(-5, 5, 0.1)
f <- function(x, y){2*x**2 - y**2}
z = outer(x, y, f)

#df/dx (x, y) = 4x
#df/dy (x, y) = -2y
xgradM = 4*0.5
ygradM = -2*0.5


#persp3d(x, y, z, col = "pink", main="arrows(.)")
contour(x, y, z, asp=1)
arrows(0.5, 0.5, 0.5+xgradM, 0.5+ygradM, col = "blue")
contour(x, y, z, levels = f(0.5, 0.5), col="orange", add=T)



#exo4-----------------------------------------
#0 = f(x0) - fp(x0)(x-x0)

newton <- function(f, fp, x0, eps, maxiter){
    for (i in seq(0, maxiter)){
        x0 = x0 - f(x0)/fp(x0)
    }
}










































