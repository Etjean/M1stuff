
/**
 *
 * @author yan jurski
 */
public class ProjetBioInfo {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        VueGenerale v;
        v = new VueExemple("/home/sdv/m1bi/ejean/Github/Java/ProjetEtienne/Images/pandemicExemple.jpg",1200,800);
        v.setCase("Paris", 570,249);
        v.setCase("Madrid", 492,287);
        ImageSimple pion=new ImageSimple("/home/sdv/m1bi/ejean/Github/Java/ProjetEtienne/Images/pin.png",25,25);
        v.positionneEnVille("Paris", pion);
        v.deplace(pion, "Paris", "Madrid");
        

        
    }
    
}
