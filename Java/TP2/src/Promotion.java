
public class Promotion {
	
	int maxEtudiants = 50;
	Personne[] etudiants = new Personne[maxEtudiants]; 
	int annee;
	
	
	Promotion (Personne[] etudiants, int annee) {							//Constructeur 1
		this.etudiants = etudiants;
		this.annee = annee;
	}
	
	
	
	
	void presentation () {							//Méthode 1
		for (int i=1; i<= this.etudiants.length; i++) {
			System.out.println(this.etudiants[i].presentation());
		}
		System.out.println(promo.annee);
	}
	
	
	
	
	public static void main(String[] args) {								//MAIN
		Personne[] etuds = creeNPersonnes(20);
		Promotion m1bib = new Promotion(creeNPersonnes(20), 2017);
	}
	
	
	
	
	
}
