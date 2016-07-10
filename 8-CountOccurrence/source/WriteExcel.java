import java.io.File;
import java.io.FileOutputStream;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.Vector;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


public class WriteExcel {
	public void WriteExcel1(String name,Double[]CaseName,String [] ActivityName,int CaseNum,int ActivityNum,int[][] M){
		//Blank workbook
        XSSFWorkbook workbook = new XSSFWorkbook();
         
        //Create a blank sheet
        XSSFSheet sheet = workbook.createSheet("Data");
          int xx=0;
        //This data needs to be written (Object[])
        Map<String, Object[]> data = new TreeMap<String, Object[]>();
        data.put("1", new Object[] {"Case ID", "Activity","Occurrence"});
        String array1 ="1";
        
        for (int i=0;i<CaseNum;i++){
        	for (int j=0;j<ActivityNum;j++){
            	array1=array1+"1";
            	data.put(array1, new Object[] {CaseName[i].intValue(), ActivityName[j],M[i][j]});
        	}
        }
    

          
        //Iterate over data and write to sheet
        Set<String> keyset = data.keySet();
        int rownum = 0;
        for (String key : keyset)
        {
            Row row = sheet.createRow(rownum++);
            Object [] objArr = data.get(key);
            int cellnum = 0;
            for (Object obj : objArr)
            {
               Cell cell = row.createCell(cellnum++);
               if(obj instanceof String)
                    cell.setCellValue((String)obj);
                else if(obj instanceof Integer)
                    cell.setCellValue((Integer)obj);
            }
        }
        try
        {
            //Write the workbook in file system
            FileOutputStream out = new FileOutputStream(new File(name));
            workbook.write(out);
            out.close();
            System.out.println("file written successfully on disk.");
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
	}
}
