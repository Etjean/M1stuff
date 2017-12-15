
public class C extends B{
	public void g(A a) {System.out.println("CA"); g(this);}
	public void g(D d) {System.out.println("CD");}
}
