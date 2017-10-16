import java.awt.Color;
import java.awt.FlowLayout;
import java.awt.Graphics;
import java.awt.Polygon;
import java.awt.image.BufferedImage;

import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;


public class Dessin {
	private static Fenetre f=new Fenetre(400,400);
	private static Color _color=Color.black;
	
	private static class Fenetre {
		private Graphics graphics;
		private JFrame localJFrame;

		public Fenetre(int width, int height, String title) {
			localJFrame = new JFrame();
			localJFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
			localJFrame.setLayout(new FlowLayout());
			BufferedImage localBufferedImage = new BufferedImage(width, height, 2);
			this.graphics = localBufferedImage.getGraphics();
			localJFrame.add(new JLabel(new ImageIcon(localBufferedImage)));
			localJFrame.setTitle(title);
			localJFrame.setSize(width + 20, height + 38);
			localJFrame.setVisible(true);
		}

		public Fenetre(int width, int height) {
			this(width, height, "TP5");
		}

		public void dessine(int[] abs, int[] ord, int length) {
		    f.fixeCouleur(_color);
			this.graphics.drawPolyline(abs,ord,length);
		}

		public void fixeCouleur(Color color) {
			this.graphics.setColor(color);
		}

		public void repaint() {
			localJFrame.repaint();
		}

	
	}
	
	public static void couleur(String s){
		if (s.equals("noir")) _color=Color.black;
		if (s.equals("rouge")) _color=Color.red;
		if (s.equals("vert")) _color=Color.green;
		if (s.equals("bleu")) _color=Color.blue;
		if (s.equals("orange")) _color=Color.orange;
		if (s.equals("rose")) _color=Color.pink;
		if (s.equals("jaune")) _color=Color.yellow;		
	}
	
	
	public static void dessine(int[][] points){
		int [] abs=new int[points.length+1];
		int [] ord=new int[points.length+1];
		for (int i=0;i<points.length;i++){
			abs[i]=points[i][0];
			ord[i]=points[i][1];
		}
		abs[points.length]=abs[0];
		ord[points.length]=ord[0];

		//Polygon p = new Polygon(abs, ord, points.length);
		f.dessine(abs,ord,points.length+1);
	}
	
}
