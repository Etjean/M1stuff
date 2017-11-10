
public class Dev {
	
	//Attributs
	int[] coeff;
	
	//Constructeur
	Dev(int[] t) {
		coeff = (int[]) t.clone();
	}
	
	
	//Methodes
	Dev add(Dev p) {
		int[] t = new int[Math.max(this.coeff.length,  p.coeff.length)];
		for (int i=0; i<t.length; i++) {
			if (i<Math.min(this.coeff.length, p.coeff.length)) {
				t[i] = this.coeff[i] + p.coeff[i];
			}
			else if (i<this.coeff.length){
				t[i] = this.coeff[i];
			}
			else t[i] = p.coeff[i];
		}
		return new Dev(t);
	}
	
	
	Dev mult(Dev p) {
		int[] t = new int[this.coeff.length+p.coeff.length];
		for (int i=0; i<this.coeff.length; i++) {
			for (int j=0; i<p.coeff.length; j++) {
				t[i+j] += this.coeff[i] + p.coeff[j];
			}
		}
		return new Dev(t);
	}
	
	
	
	
	
	
	
	
	
}
