import java.util.*;

public class Exo3 {
	public static void main(String [] argv) {
		exo3();
	}
    static boolean isInBound(int x) {
    	return (0 <= x && x <= 400);
    }
    static int askInt(String phrase) {
		System.out.println(phrase);
		Scanner sca = new Scanner(System.in);
		int x = sca.nextInt();
		if (isInBound(x)) return x;
		else return askInt(phrase);
		
    }
    public static int[] exo3() {
    	int x, y;
    	x = askInt("Veuillez entrer x");
		y = askInt("Veuillez entrer y");
		System.out.println("Vous avez entré : ("+x+", "+y+")");
		int [] tab = new int[2];
		tab[0]=x;
		tab[1]=y;
		return tab;
    }
}
