
public class Joueur {
	//Attributs
	String nom;
	String prenom;
	int clss;
	
	//Constructeur
	public Joueur(String n, String p, int c){
		nom = n;
		prenom = p;
		clss = c;
	}
	
	
	//Méthodes
	@Override
	public String toString(){
		String str = prenom+" "+nom+", classé n°"+clss;
		return str;
	}
	
	public boolean equals(Joueur j) {
		if (nom==j.nom && prenom==j.prenom && clss==j.clss) {return true;}
		else {return false;}
	}
	
	
	
	
	
}
