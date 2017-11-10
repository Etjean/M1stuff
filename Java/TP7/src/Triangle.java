import java.awt.Polygon;

public class Triangle extends Figure {
	
	//Attributs
	private int base;
	private int hauteur;
	
	
	//Constructeurs
	public Triangle(int x, int y, int b, int h) {
		super(x, y);
		base = b;
		hauteur = h;
	}
	
	//Accesseurs
	//public int getBase() {return base;}
	//public int getHauteur() {return hauteur;}
	
	
	
	//Methodes
	public Polygon creePolygon() {
		int x1, x2, x3;
		int y13, y2;
		x1 = this.getPosX() - base/2;
		x2 = this.getPosX();
		x3 = this.getPosX() + base/2;
		y13 = this.getPosY() + hauteur/2;
		y2  = this.getPosY() - hauteur/2;
		int[] abs = {x1, x2, x3};
		int[] ord = {y13, y2, y13};
		Polygon p = new Polygon(abs, ord, 3);
		return p;
	}
	
	
	
	
	
}
