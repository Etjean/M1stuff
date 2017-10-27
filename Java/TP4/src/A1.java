
public class A1 {
	public static void main(String[] args) {		//MAIN A1
		
	}
	
	private String proprietaire;					//Attributs A1
	private B b1;
	
	public A1(String proprio, int valeur){			//Contructeur A1
		this.proprietaire = proprio;
		this.b1 = new B(valeur);
	}
	
	public String toString() {
		return proprietaire + b1;
	}
	
	
	
}
