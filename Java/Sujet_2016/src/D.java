
public class D extends C{
	public void g(A a) {System.out.println("DB"); g(this);}
	public void g(D d) {System.out.println("DD");}
}
