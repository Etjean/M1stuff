
public class A2 extends B {
	public static void main(String[] args) {
		
	}
	
	private String proprietaire;
	
	public A2 (String proprio, int valeur) {
		super(valeur);
		this.proprietaire = proprio;
	}
	
	public String toString() {
		return proprietaire + super.toString();
	}
	
	
}