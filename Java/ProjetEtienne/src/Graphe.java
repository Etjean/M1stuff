import java.util.Iterator;


public interface Graphe {
	public int getNbNoeud();
	public Iterator<Integer> getNoeudsVoisin(int num);
	public void putEtiquette(String nomVille, int num);
	public void addVoisins(int num1, int num2); // graphe symétrique
	public int getNumNoeud(String nomVille);
	public Iterator<String> getVillesVoisines(String ville);
	public String toString();
}
