
public class TestBanque {
    public static void main(String [] argv){

    }
}



class Banque{
    Client[] clients;
    double tauxCheque, tauxEpargne;
    
    public Banque(double tCheque, double tEpargne, int maxClients){
	clients = new Client[maxClients];
	tauxCheque = tCheque;
	tauxEpargne = tEpargne;
    }
}


class Client {
    CompteEpargne epargne;
    CompteCheque cheque;

    public Client(double soldeEpargne, double soldeCheque){
	epargne = new CompteEpargne(soldeEpargne);
	cheque = new CompteCheque(soldeCheque);
	System.out.println("Nouveau client initialise'");
    }
    
}


class CompteEpargne {
    double solde;

    public CompteEpargne(double soldeEpargne){
	if (soldeEpargne >= 0 ) {solde = soldeEpargne;}
	else System.out.println("Erreur: compte epargne avec solde negatif");
    }
    
}


class CompteCheque {
    double solde;

    public CompteCheque(double soldeCheque){
	if (soldeCheque >= 0 ) {solde = soldeCheque;}
	else System.out.println("Erreur: compte epargne avec solde negatif");
    }
    
}
