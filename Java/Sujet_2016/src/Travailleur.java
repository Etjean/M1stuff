
public class Travailleur extends Personne {
	//Attributs 
	double salaire;
	
	//Constructeur 
	public Travailleur(String nom, double s){
		super(nom);
		salaire = s;
	}
	
	//Méthodes
	public boolean superieurOuEquivalent(Travailleur t){
		if (salaire >= t.salaire) {return true;}
		else {return false;}
	}
}
