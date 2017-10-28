import java.util.Date;

public class Froid extends Ephemere {
	final int temperature;													//Attributs Froid
	public Froid(int temperature, Date date, double cout){					//Constructeur Froid
		super(date, cout);
		this.temperature = temperature;
	}
}
