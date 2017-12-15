
public class Exo2 {
	public static void main(String[] args) {
		B b = new B(); C c = new C(); D d = new D();
		//A[] t = {(A) b, (A) c, (A) d};
		A[] t = new A[3];
		t[0] = b; t[1] = c; t[2] = d;
		
		for (A a : t) {a.g(a);}
		b.g(b);
		c.g(c);
		d.g(d);
	}

}
