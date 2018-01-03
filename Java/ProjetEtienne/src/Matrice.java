import java.util.Iterator;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.regex.*;


public class Matrice implements Graphe{

	
	//Attributs
	int nbN;
	int L, H;
	City[] cities;
	int[][] matrix;
	
	
	//Constructeur
	public Matrice(String filename) throws IOException {
		//Ouverture du fichier
		File f = new File(filename);
    	BufferedReader br = new BufferedReader(new FileReader(f));
    	//Nombre de noeuds
    	nbN = Integer.parseInt(br.readLine());
    	//Largeur & Hauteur
    	String line = br.readLine();
    	String[] words = line.split(" ");
    	L = Integer.parseInt(words[0]);
    	H = Integer.parseInt(words[1]);
    	//Creation des villes
    	cities = new City[nbN];
		Pattern p = Pattern.compile("([a-zA-Z\\s]+)\\s#|([0-9]+)");
    	for (int i=0; i<48 ; i++){
    		line = br.readLine();
    		Matcher m = p.matcher(line);
    		
    		int no = i+1;
    		m.find();
			String cityname = m.group(1).trim();
			m.find();
			String color = m.group(1).trim();
			m.find();
			int posX = Integer.parseInt(m.group(2));
			m.find();
			int posY = Integer.parseInt(m.group(2));
    		cities[i] = new City(no, cityname, color, posX, posY);
    	}
    	
    	//Creation de la matrice d'adjacence
    	matrix = new int[nbN][nbN];
    	while ((line = br.readLine()) != null) {
    		String[] names = line.split("##");
    		int no1 = getNumNoeud(names[0].trim());
    		int no2 = getNumNoeud(names[1].trim());
    		matrix[no1-1][no2-1] = 1;
    		matrix[no2-1][no1-1] = 1;
    	}
    	br.close();
	}
	
	
	
	
	
	
	
	
	
	
	
	
	@Override
	public int getNbNoeud() {
		//retourne le nombre de noeuds du jeu
		return nbN;
	}

	@Override
	public Iterator<Integer> getNoeudsVoisin(int num) {
		//Retourne les numeros des villes voisines à la ville n°"num"
		return null;
	}

	@Override
	public void putEtiquette(String nomVille, int num) {
		//Associe un nom de ville à un numero
	}

	@Override
	public void addVoisins(int num1, int num2) {
		//ajoute un lien entre les villes n°1 et n°2
		matrix[num1-1][num2-1] = 1;
		matrix[num2-1][num1-1] = 1;
	}

	@Override
	public int getNumNoeud(String nomVille) {
		//Retourne le numero de la ville "nomVille"
		for(City c : cities){
			if (c.name.equals(nomVille)){
				return c.no;
			}
		}
		return 0;
	}
	
	@Override
	public Iterator<String> getVillesVoisines(String nomVille) {
		//Retourne les noms des villes voisines à la ville "nomVille"
		return null;
	}
	
	
	
	
	
	
}
