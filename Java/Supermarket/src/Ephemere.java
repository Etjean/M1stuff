import java.util.Date;

public class Ephemere extends Produit {
	final Date date;												//Attributs Ephemere
	public Ephemere(Date date, double cout){						//Constructeur Ephemere
		super(cout);
		this.date = date;
	}
	public boolean ok(Date today){
		return (this.date.after(today));
	}
	
}
