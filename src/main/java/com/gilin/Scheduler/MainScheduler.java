package com.gilin.Scheduler;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.File;
import java.io.FileFilter;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.Locale;

@Component
public class MainScheduler {


    /* 매일 새벽 1시에 전일 editor_temp폴더에 잔여 이미지 삭제 */
	//@Scheduled(cron = "0/5 * * * * *")
	@Scheduled(cron = "0 0 01 * * ?")
    public void run() throws Exception {

        System.out.println("------------- " + LocalDateTime.now() + " :: editer temp 이미지 삭제 -------------");

        Date dDate = new Date();
        dDate = new Date(dDate.getTime()+(1000*60*60*24*-1));
        SimpleDateFormat dSdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
        String yesterday = dSdf.format(dDate);

        //String url = "/Users/imgtest";
        String url = "/var/upload/img/editor_temp";
    	File fileDir = new File(url); 
    	
    	FileFilter filter = new FileFilter() {
    	    public boolean accept(File f) {
    	        return f.getName().contains("_" + yesterday);
    	    }
    	};
    	
    	if(fileDir.exists()) { 
    		//파일 리스트 추출
    		File[] fileNames = fileDir.listFiles(filter);
    		System.out.println("fileNames.length : "+fileNames.length);
    		
    		for(int i=0; i< fileNames.length; i++) { 
    			if(fileNames[i].isFile() && fileNames[i].exists()) { 
    				System.out.println(fileNames[i].getName());
    				fileNames[i].delete();
    				
    			}
    		}

    	}
        
    }

}
