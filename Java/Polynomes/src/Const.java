
public class Const extends Poly {
	
	//Attributs
	int value;
	
	
	//Constructeur
	Const(int value) {
		this.value = value;
	}
	
	
	
	//Méthodes
	int eval(int x) {return value;}
	
	public String toString() {return (new Integer(value)).toString();}

	Dev dev() {return null;}
	
	
	
}
