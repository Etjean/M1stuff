
public class Joueur {
	//Attributs
	String nom;
	String prenom;
	int clss;
	
	//Méthodes
	public boolean equals(Joueur j) {
		if (nom == j.nom && prenom == j.prenom && clss == j.clss) {return true;}
		else {return false;}
	}
	
}

