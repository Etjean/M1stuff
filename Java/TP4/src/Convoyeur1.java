
public class Convoyeur1 {
	public static void main(String[] args) {
		// TODO Auto-generated method stub
	}
	
	private A1[] tabA1;
	private B[] tabB;
	
	Convoyeur1 (tabA1[] tabA1, tabB[] tabB){
		this.tabA1 = tabA1;
		this.tabB = tabB;
	}
	
	
	public int valGlobale(){
		int val = 0;
		for (int i=1; i <= 100; i++){
			val += this.tabA1[i].valeur;
			val += this.tabB[i].valeur;
		}
		return(val);
		
	}
	
	
	
	
	
	
}
