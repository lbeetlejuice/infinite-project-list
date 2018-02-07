public class GameOfLife {
	public static void main(String[] args){
		
		int groesse = (int) Integer.parseInt(args[0]);
		int generationen = 100; 		
		int zeit = 100; 				
		
		boolean[][] arrayGoL = new boolean[groesse][groesse];
		
		fuelleArrayGoL(arrayGoL);		
		for(int i = 0; i < generationen; i++){
			try{
				for(int c=0;c<50;c++){System.out.println("\n");}
				System.out.println(i+". Generation");
				neueGeneration(arrayGoL);
				Thread.sleep(zeit);
			}
			catch(InterruptedException ire){}
		}
	}
	
//--------------------------------------------------------------------------------------
	
	private static int getZufallszahl(int n){
		return (int) (Math.random()*(n));
	}
	
	private static void fuelleArrayGoL(boolean[][] array){
		for(int zeile = 0; zeile < array.length; zeile++){
			for(int spalte = 0; spalte < array[zeile].length; spalte++){
				int zahl = getZufallszahl(2)+1;
				if(zahl == 1){ array[zeile][spalte] = true; }
				else{ array[zeile][spalte] = false; }
			}
		}
	}
	
	private static void neueGeneration(boolean[][] array){
		boolean[][] neueGen = new boolean[array.length][array[0].length];
		
		for (int zeile = 0; zeile < array.length; zeile++){
			for (int spalte = 0; spalte < array.length; spalte++){
				int nachbarn = zaehleNachbarn(zeile, spalte, array);
				
				if (nachbarn < 2 || nachbarn > 3) {
					neueGen[zeile][spalte] = false;
				} 
				else if(array[zeile][spalte] == true || (array[zeile][spalte] != true && nachbarn == 3)){
					neueGen[zeile][spalte] = true;
				}
			}
		}
		ausgabeArray(neueGen);
		kopiereArray(neueGen, array);
	}

	private static void ausgabeArray(boolean[][] array){
		for(int y=0;y<array.length+1;y++){System.out.print("---");}
		System.out.println("-");
		for(int w = 0; w < array.length; w++){
			System.out.print("| ");
			for(int q = 0; q < array.length; q++){
				if(array[w][q] == true){
					System.out.print(" * ");
				}
				else{
					System.out.print("   ");
				}
			}
		System.out.print(" |");
		System.out.println("");
		}
		for(int y=0;y<array.length+1;y++){System.out.print("---");}
		System.out.println("-");
	}

	private static void kopiereArray(boolean[][] neu, boolean[][] alt){
		for (int zeile = 0; zeile < neu.length; zeile++){
			for (int spalte = 0; spalte < neu.length; spalte++){
				alt[zeile][spalte] = neu[zeile][spalte];
			}
		}
	}	
	
	private static int zaehleNachbarn(int zeile, int spalte, boolean[][] array){
		int counter = 0;
		for (int z = -1; z <= 1; z++) {
			for (int s = -1; s <= 1; s++) {
				int aktZeile = (z + zeile + array.length) % array.length;
				int aktSpalte = (s + spalte + array.length) % array.length;
				if (s == 0 && z == 0) {
				} else if(array[aktZeile][aktSpalte] == true){
						counter = counter + 1;
				}
			}
		}
		return counter;
	}
}