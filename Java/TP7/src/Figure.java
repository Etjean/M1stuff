import java.awt.Polygon;

public abstract class Figure {
	
	//Attributs
	private int posX;
	private int posY;
	
	
	//Constructeur
	public Figure(int x, int y) {
		posX=x;
		posY=y;
	}
	
	
	//Accesseurs
	public int getPosX() {return posX;}
	public int getPosY() {return posY;}
	
	
	
	//Méthodes
	public abstract Polygon creePolygon();
	
	
	
	
	
}
