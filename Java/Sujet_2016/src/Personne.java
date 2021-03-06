


public class Personne {
	//Attributs
	String nom;
	
	
	//Constructeur
	public Personne (String nom){
		this.nom = nom;
	}
	
	//Méthodes
	public boolean superieurOuEquivalent(Personne p){
		if (((int) nom.charAt(0)) <= ((int) p.nom.charAt(0))) {return true;}
		else {return false;}
	}
	
	public int supOuEq(Personne p){
		return this.nom.compareTo(p.nom);
	}
	
	@Override
    public boolean equals(Object o){
        if(!(o instanceof Personne)){
            return false;
        }
        return this.nom.equals(((Personne)o).nom);
    }
	
}
