import java.io.IOException;


public class Test {

	public static void main(String[] args) throws IOException {
		Matrice mat = new Matrice("/home/sdv/m1bi/ejean/Github/Java/Projet/ExempleFichierGrapheVilles.tex");
		System.out.println(mat.L);
		System.out.println(mat.H);
		System.out.println(mat.cities[47].no);
		System.out.println(mat.cities[47].name);
		System.out.println(mat.cities[47].color);
		System.out.println(mat.cities[47].posX);
		System.out.println(mat.cities[47].posY);
	}
}
