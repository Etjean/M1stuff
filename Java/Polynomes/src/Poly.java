
public abstract class Poly {
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Poly p1 = new Add(new Var(), new Const(2));
		Poly p2 = new Mult(new Mult(new Var(), new Var()), p1);
		
		
	}
	
	
	
	//Méthodes
	Poly add(Poly p) {return new Add(this, p);}
	
	Poly mult(Poly p) {return new Mult(this, p);}
	
	abstract int eval(int x);
	
	abstract Dev dev();
	
	
	
	
	
	
	
	
	
	
	
	
}
