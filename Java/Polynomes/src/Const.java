
public class Const extends Poly {
	
	//Attributs
	int value;
	
	
	//Constructeur
	Const(int value) {
		this.value = value;
	}
	
	
	
	//Méthodes
	int eval(int x) {return value;}
	
	String toString() {return (new Integer(value)).toString();}
	
	
	
}
