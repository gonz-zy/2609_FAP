package model;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

public class DateContextListener implements ServletContextListener {
    
    Timer timer;
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        updateDate(sce);
        timer = new Timer(true);
        timer.scheduleAtFixedRate(new TimerTask(){
            public void run(){
                updateDate(sce);
            }
        }, 0, 1000);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (timer != null) {
            timer.cancel();
        }
        
    }
    
    public void updateDate(ServletContextEvent sce){
        Date date = new Date();
        sce.getServletContext().setAttribute("currentDate", date);
    }
}