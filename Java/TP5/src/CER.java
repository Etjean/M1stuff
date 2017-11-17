
public class CER extends MP{
	
	//Attributs
	private static double taux = 0.01;
	private double solde;
	
	//Constructeur
	public CER(String c, String b) {
		super(c, b);
		solde=0;
	}
	
	//Methodes
	public boolean depot(double m) {
		if(m<0){return false;}
		else{solde+=m; return true;}
	}

	
	
	
}
