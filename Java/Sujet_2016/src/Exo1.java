
public class Exo1 {
	public static void main(String[] args);
}












public int indexOf(Integer e){
	Cell cell = first;
	int i = 0;
	while (cell != null){
		if (cell.element == e){
			return i;
		}
		else {
			i++;
			cell = cell.next;
		}
	}
	return -1;
}




