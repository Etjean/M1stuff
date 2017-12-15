
public class Etudiant extends Personne{
	//Attributs
	int dureeDEtude;
	Formation formation;
	
	//Constructeur
	public Etudiant(String nom, int dde, Formation f){
		super(nom);
		dureeDEtude = dde;
		formation = f;
	}
	
	//Méthodes
	public boolean superieurOuEquivalent(Etudiant e){
		if (dureeDEtude >= e.dureeDEtude) {return true;}
		else {return false;}
	}
}
