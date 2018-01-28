

taille_pop = 30
start_proportion = 0.3
nb_generation = 100
nb_simulations = 1


plot(0, type='l', xlim=c(0,nb_generation), ylim=c(0,1),
     main="DERIVE GENETIQUE :\nEvolution de la proportion d'un allèle\ndans une population",
     xlab="numéro de génération", ylab="proportion de l'allèle")

for(j in 1:nb_simulations){
  x = c(start_proportion)
  for (i in 1:nb_generation){
    x = c(x, rbinom(1, taille_pop, x[length(x)])/taille_pop)
  }
  lines(x)
}
















