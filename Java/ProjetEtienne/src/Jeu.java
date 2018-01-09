import java.io.IOException;


public class Jeu {
	
	public static void main(String[] args) throws IOException {
		Prototype prot = new Prototype();
		while (true){
			for (Joueur j : prot.players){
				prot.tourDeJeu(j);
			}
		}
	}
}
