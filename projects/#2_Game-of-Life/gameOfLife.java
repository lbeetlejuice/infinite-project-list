public class GameOfLife {
	public static void main(String[] args){

		int size = (int) Integer.parseInt(args[0]);
		int generations = 100;
		int time = 100;

		boolean[][] arrayGoL = new boolean[size][size];

		fillArrayGoL(arrayGoL);
		for(int i = 0; i < generations; i++){
			try{
				for(int c=0;c<50;c++){System.out.println("\n");}
				System.out.println(i+". Generation");
				newGeneration(arrayGoL);
				Thread.sleep(time);
			}
			catch(InterruptedException ire){}
		}
	}

//--------------------------------------------------------------------------------------

	private static int getRandomNumber(int n){
		return (int) (Math.random()*(n));
	}

	private static void fillArrayGoL(boolean[][] array){
		for(int row = 0; row < array.length; row++){
			for(int column = 0; column < array[row].length; column++){
				int number = getRandomNumber(2)+1;
				if(number == 1){ array[row][column] = true; }
				else{ array[row][column] = false; }
			}
		}
	}

	private static void newGeneration(boolean[][] array){
		boolean[][] newGen = new boolean[array.length][array[0].length];

		for (int row = 0; row < array.length; row++){
			for (int column = 0; column < array.length; column++){
				int neighbor = countNeighbor(row, column, array);

				if (neighbor < 2 || neighbor > 3) {
					newGen[row][column] = false;
				}
				else if(array[row][column] == true || (array[row][column] != true && neighbor == 3)){
					newGen[row][column] = true;
				}
			}
		}
		outputArray(newGen);
		copyArray(newGen, array);
	}

	private static void outputArray(boolean[][] array){
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

	private static void copyArray(boolean[][] new, boolean[][] alt){
		for (int row = 0; row < new.length; row++){
			for (int column = 0; column < new.length; column++){
				alt[row][column] = new[row][column];
			}
		}
	}

	private static int countNeighbor(int row, int column, boolean[][] array){
		int counter = 0;
		for (int z = -1; z <= 1; z++) {
			for (int s = -1; s <= 1; s++) {
				int actRow = (z + row + array.length) % array.length;
				int actColumn = (s + column + array.length) % array.length;
				if (s == 0 && z == 0) {
				} else if(array[actRow][actColumn] == true){
						counter = counter + 1;
				}
			}
		}
		return counter;
	}
}
