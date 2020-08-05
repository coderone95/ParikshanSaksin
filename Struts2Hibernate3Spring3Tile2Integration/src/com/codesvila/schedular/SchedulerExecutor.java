package com.codesvila.schedular;

import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import org.apache.log4j.Logger;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;

import com.codesvila.processExecutor.ProcessExecutor;

public class SchedulerExecutor {

	private static final Logger LOG = Logger.getLogger(SchedulerExecutor.class);
	
	private ScheduledExecutorService schedular;

	public SchedulerExecutor(final ThreadPoolTaskScheduler schedular1) {
		schedular1.setPoolSize(10);
		schedular1.initialize();
		schedular1.setThreadNamePrefix("Schedular Worker-");
		this.schedular = schedular1.getScheduledExecutor();
		this.schedular.execute(new Runnable() {
			@Override
			public void run() {
				// TODO Auto-generated method stub
				startScheduleTask();
//				new ProcessExecutor().process();
			}
		});
	}
	
	public void startScheduleTask() {
//		final ScheduledFuture<?> taskHandle = schedular.scheduleAtFixedRate(new Runnable() {
//			public void run() {
//				try {
//					getDataFromDatabase();
////					new ProcessExecutor().process();
//				} catch (Exception ex) {
//					ex.printStackTrace(); // or loggger would be better
//				}
//			}
////		}, 0, 2, TimeUnit.MINUTES);
//		}, 0, 2, TimeUnit.SECONDS);

		Runnable task = new Runnable() {
            public void run() {
            	try {
					new ProcessExecutor().process();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
            }
        };
        
		schedular.schedule(task, 5, TimeUnit.SECONDS);
		
	}

	private void getDataFromDatabase() {
//		LOG.debug("Message --------------- Getting Data from Database");
		System.out.println("Message --------------- Getting Data from Database");
	}
}