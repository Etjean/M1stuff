
import java.util.*; //importation de Scanner


public class Exo1 {
    public static void main (String [] argv) {
        Scanner sc = new Scanner(System.in);
        int x, y;
        System.out.println("Entrez les coordonées (x, y) :");
        System.out.println("Entrez x :");
        do {x = sc.nextInt();} while (x<0 || x>400);
        System.out.println("Entrez y :");
        do {y = sc.nextInt();} while (y<0 || y>400);
        System.out.println("x = "+x);
        System.out.println("y = "+y);
        sc.close();
    }
}

































