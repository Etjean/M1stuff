


public class TestBanquePerso {
	public static void main(String[] args) {
		Banque laBanquePostale = new Banque(10);
		Client miara = new Client(1000000000, 2);
		Client etienne = new Client(600, 8000);
		Client yann = new Client(3000, 200);
		Client jannis = new Client(18000, 600);
		System.out.println("etienne");
		etienne.ce.modifSolde(600);
		System.out.println(etienne.ce.solde);
		
		
	}
}



class Banque {
	Client[] clients;										//Attributs
	
	Banque (int maxclients) {								//Constructeur
		this.clients = new Client[maxclients];
	}
}


class Client {
	CompteEpargne ce;										//Attributs
	CompteCheque cc;

	Client (double soldeE, double soldeC) {					//Constructeur
		this.ce = new CompteEpargne(soldeE, 0);
		this.cc = new CompteCheque(soldeC, 0);
		System.out.println("Nouveau client initialisé");
	}
}



class CompteEpargne {
	double solde;											//Attributs
	double interet;
	
	CompteEpargne (double solde, double interet) {			//Constructeur
		this.solde = solde;
		this.interet = interet;
	}
	
	void modifSolde (double montant) {						//Methode
		if (montant >= 0) {this.solde += montant;}
		else {System.out.println("Vous ne pouvez pas effectuer de retrait sur votre compte épargne");}
	}
}





class CompteCheque {
	double solde;											//Attributs
	double interet;
	
	CompteCheque (double solde, double interet) {			//Constructeur
		this.solde = solde;
		this.interet = interet;
	}
	
	void modifSolde (double montant) {						//Methode
		this.solde += montant;
	}
}
















