import java.awt.AlphaComposite;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;
import javax.swing.JPanel;


public class ImageSimple extends JPanel{ 
	private static final long serialVersionUID = 1L;
	protected Image buffer;
	protected int largeur;
	protected int hauteur;
	
	protected int surCase;

    public ImageSimple(String name, int x, int y){
    	File pathToFile = new File(name);
    	try {
    		buffer = ImageIO.read(pathToFile);
    	} catch (IOException e) {
			e.printStackTrace();
        }
    	buffer= resizeImage(buffer,x, y);
    	largeur=x;
    	hauteur=y;
    	surCase=-1;
    } 
    
    
    private static BufferedImage resizeImage(final Image image, int width, int height) {
        final BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
        final Graphics2D graphics2D = bufferedImage.createGraphics();
        graphics2D.setComposite(AlphaComposite.Src);
        graphics2D.drawImage(image, 0, 0, width, height, null);
        graphics2D.dispose();
 
        return bufferedImage;
    }
    
        @Override
    public void paintComponent(Graphics g) {
 	       g.drawImage(buffer,0,0,null);
 	}
    
}
