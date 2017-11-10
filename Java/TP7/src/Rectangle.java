import java.awt.Polygon;

public class Rectangle extends Carre {	
	
	//Attributs
	private int hauteur;
	
	
	//Constructeur
	public Rectangle(int x, int y, int l, int h) {
		super(x, y, l);
		hauteur=h;
	}
	
	//Accesseurs
	public int getHauteur() {return hauteur;}
	
	
	
	//Methodes
	public Rectangle deforme(double x, double y) {
		Rectangle rd = new Rectangle(this.getPosX(), this.getPosY(),
				(int) (this.getLargeur()*x), (int)(this.getHauteur()*y));
		return rd;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
