import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.Vector;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


public class ActivityCounter {

	public void CountActivity(){
	
	}
	
	
	public void ReadExcelLog (String name,Vector Lcase,Vector Lactivity,int Rheading,int Ccase,int Cactivity){

		try
        {
            FileInputStream file = new FileInputStream(new File(name));
 
            //Create Workbook instance holding reference to .xlsx file
            XSSFWorkbook workbook = new XSSFWorkbook(file);
 
            //Get first/desired sheet from the workbook
            XSSFSheet sheet = workbook.getSheetAt(0);
 
            //Iterate through each rows one by one
            Iterator<Row> rowIterator = sheet.iterator();
            while (rowIterator.hasNext())
            {
            
                Row row = rowIterator.next();
                //For each row, iterate through all the columns
                Iterator<Cell> cellIterator = row.cellIterator();
                 
                while (cellIterator.hasNext())
                {
                
                    Cell cell = cellIterator.next();
                    
                    if (row.getRowNum()>Rheading-1){
                    	if(cell.getColumnIndex()==Ccase-1){
                            //Check the cell type and format accordingly
                            switch (cell.getCellType())
                            {
                                case Cell.CELL_TYPE_NUMERIC:
                                    Lcase.addElement(new Double(cell.getNumericCellValue()));
                                    break;
                                case Cell.CELL_TYPE_STRING:
                                	Lcase.addElement(new String(cell.getStringCellValue()));

                            }
                        }else if ((cell.getColumnIndex()==Cactivity-1)){
                            //Check the cell type and format accordingly
                            switch (cell.getCellType())
                            {
                                case Cell.CELL_TYPE_NUMERIC:
                                	Lactivity.addElement(new Double(cell.getNumericCellValue()));
                                    break;
                                case Cell.CELL_TYPE_STRING:
                                	Lactivity.addElement(new String(cell.getStringCellValue()));

                            }
                        }
                    	}

                }

            }
            file.close();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
	}


}
