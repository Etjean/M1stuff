
public abstract class MP {
	
	//Attributs
	protected final String client;
	protected final String banque;
	
	//Constructeur
	public MP (String c, String b) {
		client=c;
		banque=b;
	}
	
	//Méthodes
	public abstract boolean retrait(double s);
	public abstract boolean depot(double s);
	public boolean verif(String nom) {return(client.equals(nom));}
	//public abstract boolean bilan();
		
}
