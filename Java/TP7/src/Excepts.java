import java.util.Random;

public class Excepts {
	public static void main(String[] args) throws Oups {
		
		int m = 3;
		int rep = 5000;
		int[] tab = tab_aleatoire(m);
		
		try {System.out.println(divisions_successives(rep, tab));}
		catch (Exception e) {throw new Oups(e.getMessage());}
		
		
	}
	
	
	
	
	//Methodes
	public static int divise(int a, int b) {
		return a/b;
	}
	
	public static int[] tab_aleatoire(int n) {
		int[] tab = new int[n];
		Random rd = new Random();
		for (int i=0; i<n; i++){
			tab[i]=rd.nextInt(10);
		}
		return tab;
	}
	
	public static int divisions_successives(int n, int[] tab) {
		for (int i=0; i<tab.length; i++) {
			try {n = divise(n, tab[i]);}
			catch() {;}
		}
		try {return tab[n];}
		catch(Exception e) {throw new Oups("tableau trop petit. Indice essayé = " + n);}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
