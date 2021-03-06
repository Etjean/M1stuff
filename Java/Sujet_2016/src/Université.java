import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.util.Set;


public class Université {
	//Attributs
	Set<Personne> membres;
	Travailleur president;
	
	//Constructeur
	public Université(Set<Personne> mbs, Travailleur pres){
		membres = mbs;
		president = pres;
	}
	
	//Methodes
	public double masseSalariale(){
		double ms = 0;
		ms += president.salaire;
		for (Personne p : membres){
			if (p instanceof Travailleur){
				ms += ((Travailleur) p).salaire;
			}
		}
		return ms;
	}
	
	public List<Etudiant> listeEtudiants(Formation f){
		List<Etudiant> l = new ArrayList<Etudiant>();
		for (Personne p : membres){
			if (p instanceof Etudiant){
				Etudiant e = (Etudiant) p;
				if (e.formation == f){
					l.add(e);
				}
			}
		}
		return l;
	}
	
	public static Université fusion(Université u1, Université u2){
		//Choix du nouveau président
		Scanner sc = new Scanner(System.in);
		System.out.println("Quel président voulez-vous mettre à la tête de l'université ?");
		System.out.println(u1.president.nom+" ou "+u2.president.nom+" ?");
		String nom = sc.next();
		while (!(nom.equals(u1.president.nom) || (nom.equals(u2.president.nom)))){
			System.out.println("Erreur : veuillez taper un des noms proposés");
			System.out.println(u1.president.nom+" ou "+u2.president.nom+" ?");
			nom = sc.next();
		}
		Travailleur p;
		if (nom.equals(u1.president)){p = u1.president;}
		else {p = u2.president;}
		//Fusion des membres
		u1.membres.addAll(u2.membres);
		Université u = new Université(u1.membres, p);
		for (Personne pers : u1.membres){System.out.println(pers.nom);}
		System.out.println("FUSION DONE !");
		return u;
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
