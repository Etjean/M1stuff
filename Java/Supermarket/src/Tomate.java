import java.util.Date;

public class Tomate extends Ephemere {
	static double prix;
	Tomate (Date date, double cout, double prix){
		super(date, cout);
		Tomate.prix = prix;
	}
}
