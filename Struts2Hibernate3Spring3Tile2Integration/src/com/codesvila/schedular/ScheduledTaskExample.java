package com.codesvila.schedular;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

public class ScheduledTaskExample {
//	private final ScheduledExecutorService scheduler = Executors
//	        .newScheduledThreadPool(1);
	private final ScheduledExecutorService scheduler = Executors.newSingleThreadScheduledExecutor();
	
	public void startScheduleTask() {
	    /**
	    * not using the taskHandle returned here, but it can be used to cancel
	    * the task, or check if it's done (for recurring tasks, that's not
	    * going to be very useful)
	    */
	    final ScheduledFuture<?> taskHandle = scheduler.scheduleAtFixedRate(
	        new Runnable() {
	            public void run() {
	                try {
	                    getDataFromDatabase();
	                }catch(Exception ex) {
	                    ex.printStackTrace(); //or loggger would be better
	                }
	            }
	        }, 0, 2, TimeUnit.MINUTES);
	    }

	    private void getDataFromDatabase() {
	        System.out.println("getting data...");
	    }

	    public static void main(String[] args) {
	        ScheduledTaskExample ste = new ScheduledTaskExample();
	        ste.startScheduleTask();
	    }
}
