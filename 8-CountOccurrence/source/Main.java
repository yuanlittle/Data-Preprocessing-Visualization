
import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import java.util.Vector;



public class Main {
	public static void main (String args []) {
		//motify here
		String inputFileName="test.xlsx";//must be .xlsx file
		String ouputFileName="Occurrence.xlsx";//must be .xlsx file
		int headingRow=8;
		int caseIDColumn=5;
		int activityColumn=6;
		//function
		CountOccurrence(inputFileName,headingRow,caseIDColumn,activityColumn,ouputFileName);

	}
	public static void CountOccurrence(String name,int Rheading,int Ccase,int Cactivity,String outputName){
		//collect case name
				Vector l1 =new Vector();
				//collect activity name
				Vector<String> l2 =new Vector<String>();
				//number in each case
				Vector Casebound=new Vector();
				ActivityCounter A1= new ActivityCounter();
				A1.ReadExcelLog(name, l1,l2,Rheading,Ccase,Cactivity);

				Set<Double> uniqueCase = new HashSet<Double>(l1);
				Set<String> uniqueActivity = new HashSet<String>(l2);
				String []UniqueActivity=uniqueActivity.toArray(new String[uniqueActivity.size()]);
				Double []UniqueCase=uniqueCase.toArray(new Double[uniqueCase.size()]);
				for (int i=0;i<UniqueCase.length;i++){
					Casebound.addElement(l1.lastIndexOf(UniqueCase[i]));
				}
				Collections.sort(Casebound);
				Arrays.sort(UniqueCase);
				//zero matrix
				int [][] M=new int[uniqueCase.size()][uniqueActivity.size()];
				//count number
				int rowCurrent=0;

				
				for (int i=0;i<l2.size();i++){

					for(int j=0;j<UniqueActivity.length;j++){
						if(l2.elementAt(i).equals(UniqueActivity[j])){
							M[rowCurrent][j]++;
							break;
						}
					}

					if ((i==(int) Casebound.elementAt(rowCurrent))&&(i!=(int)Casebound.lastElement())){
						rowCurrent++;
					}
				}
				WriteExcel W1= new WriteExcel();
				W1.WriteExcel1(outputName, UniqueCase, UniqueActivity, UniqueCase.length, UniqueActivity.length, M);
	}
	
	

}
