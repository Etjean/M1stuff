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
		
		System.out.println("");
		System.out.println(mat.cities[3].name + " " + mat.cities[6].name);
		System.out.println(mat.matrix[3][6]);
		System.out.println("");
		System.out.println(mat.cities[13].name + " " + mat.cities[16].name);
		System.out.println(mat.matrix[13][16]);
		System.out.println("");
		System.out.println(mat.cities[13].name + " " + mat.cities[36].name);
		System.out.println(mat.matrix[13][36]);
		
		System.out.println("");
		System.out.println(mat.getNumNoeud("Los Angeles"));
	}
}
