import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Iterator;
import java.util.Vector;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class Main {
	
	public static void main (String args []) {
		//*****Activity Num******
		int row=98;
		//************
		int column=row;
		double [][] M=new double[row][column];
		Vector<Double> L=new Vector<Double>(); 
		ReadExcel Read1= new ReadExcel();
		Read1.ReadExcelMatrix("1storderProbability.xlsx",L);
		for (int i=0;i<row;i++) {
			for (int j=0;j<column;j++){
				M[i][j]=(double) L.elementAt(row*i+j);
				//System.out.print(M[i][j]+" ");
			}
			//System.out.print("\n");

		}
		L.clear();
		ReadExcel Read2=new ReadExcel();
		Read2.ReadExcelMatrix("1stoderInitilizationProbability.xlsx", L);
		
		//legend
		Vector<String> Llegend=new Vector<String>();
		ReadExcel Read3=new ReadExcel();
		Read3.ReadExcelMatrix("name.xlsx", Llegend);
		//***********************
		int CaseNum=6;
		int LengthOfCase=90;
		//***********************
		Vector<Double> Lrow=new Vector<Double>();
		Vector<Integer> Lnew=new Vector<Integer>();
		
		for (int k=0;k<CaseNum;k++){
			//First New one
			Lnew.add(getRandom(L));
			//Generate new one
			for (int i=0;i<LengthOfCase-1;i++){
				for(int j=0;j<column;j++){
					Lrow.addElement(M[Lnew.lastElement()-1][j]);
				}
				Lnew.add(getRandom(Lrow));
				Lrow.clear();
			}	
		}

		
		//change index to name
		Vector<String> Lfinal=new Vector<String>();
		for (int i=0;i<Lnew.size();i++){
			Lfinal.add(Llegend.elementAt(Lnew.elementAt(i)-1));
		}
		
		
		WriteExcel Write1 = new WriteExcel();
		Write1.WriteExcel1("NewData.xlsx",Lfinal,CaseNum,LengthOfCase);

		
	}
	
	public static int getRandom(Vector<Double> L){
		double num=Math.random();
		double s=0;
		int lastIndex=L.size()-1;
		for (int i=0;i<lastIndex;i++){
			double weight=L.elementAt(i);
			s=s+weight;
			if (num<s){
				return i+1;
			}
		}
		return L.size();
	}
}

