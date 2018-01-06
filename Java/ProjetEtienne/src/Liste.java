import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.Iterator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class Liste implements Graphe{
	//Attributs
	int nbN;
	int L, H;
	City[] cities;
	int[][] list;
	
	
	//Constructeur
	public Liste(String filename) throws IOException {
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
    	
    	//Creation de la liste d'adjacences
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