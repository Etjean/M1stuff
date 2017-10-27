
public class B {
	public static void main(String[] args) {
		
	}
	
	private int valeur;							//Attributs B
	
	public B (int valeur) {						//Constructeur B
		this.valeur = valeur;
	}
	
	public String toString() {
		return ("valeur = "+ this.valeur);
	}
	
	public int getVal() {
		return this.valeur;
	}
}
