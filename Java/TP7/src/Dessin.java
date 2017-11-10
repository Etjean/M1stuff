import java.awt.Color;
import java.awt.FlowLayout;
import java.awt.Graphics;
import java.awt.Polygon;
import java.awt.image.BufferedImage;
import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;

public class Dessin {
	private Graphics graphics;
	private JFrame localJFrame;

	public Dessin(int width, int height, String title) {
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

	public Dessin(int width, int height) {
		this(width, height, "TP5");
	}

	public Dessin() {
		this(500, 500);
	}

	public void dessine(Polygon polygon) {
		this.graphics.fillPolygon(polygon);
	}

	public void fixeCouleur(Color color) {
		this.graphics.setColor(color);
	}

	public void repaint() {
		localJFrame.repaint();
	}
}