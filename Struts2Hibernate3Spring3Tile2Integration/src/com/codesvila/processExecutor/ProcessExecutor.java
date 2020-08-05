package com.codesvila.processExecutor;

import java.text.ParseException;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import org.apache.log4j.Logger;

import com.codesvila.bean.TestBO;
import com.codesvila.datasource.ApacheCommonsDBCP;
import com.codesvila.schedular.workers.Worker;
import com.codesvila.utils.DateUtils;

public class ProcessExecutor {
	private static final Logger LOG = Logger.getLogger(ProcessExecutor.class);

	public void process() throws Exception {
		LOG.info("ProcessExecutor.process()--- start");
		List<Worker> allworkers = new Worker().getAllWorkers();
		if (allworkers.size() > 0 && allworkers != null) {
			for (Worker worker : allworkers) {
				String workerName = worker.workerName;
				if (workerName.equalsIgnoreCase("TestExpirationScheduleWorker")) {
					// String scheduleType = worker.scheduleType;
					processScheduler(worker);
				}
			}
		}
		LOG.info("ProcessExecutor.process()--- end");
	}

	private void processScheduler(Worker worker) throws ParseException {
		// TODO Auto-generated method stub
		String workerName = worker.getWorkerName();
		switch (workerName) {

		case "TestExpirationScheduleWorker":
			String scheduleType = worker.scheduleType;
			if (scheduleType != null && scheduleType.equalsIgnoreCase("scheduleAtSpecificTime")) {
				executeSchedulerWorkerScheduleAtSpecificTime(worker);
			}
			break;
		default:
			LOG.info("Uknown match");

		}
	}

	@SuppressWarnings("unchecked")
	private void executeSchedulerWorkerScheduleAtSpecificTime(Worker worker) throws ParseException {
		// TODO Auto-generated method stub
		if (worker.getWorkerName().equalsIgnoreCase("TestExpirationScheduleWorker")) {
			try {
				Map<String, Object> scheduleParams = worker.getScheduleParams();
				List<TestBO> testsBO = new ArrayList<>();
				LocalDateTime expirationDateForTest = null;
				if (scheduleParams.containsKey("testsBO")) {
					testsBO = (List<TestBO>) scheduleParams.get("testsBO");
				}
				if (testsBO.size() > 0 && testsBO != null) {
					for (TestBO test : testsBO) {
						Integer testID = test.getTest_id();
						String expirationDate = test.getEndOn();
						if (expirationDate != null && expirationDate != "") {
							expirationDateForTest = DateUtils.getLocalDateTimeFromDate(expirationDate.replace(".0", ""));
						}
						Date dateObj = DateUtils.getFormattedDate(expirationDate);
						Date current = new Date();
						int diff = dateObj.compareTo(current);
						if (diff <= 0) {
							LOG.info("updating expiration flag -- start");
							List<Integer> param = new ArrayList<Integer>();
							param.add(testID);
							ApacheCommonsDBCP.DBCPDataSource("CALL_UPDATE_EXPIRAED_TEST_PROC", param, true, null,null);
							LOG.info("updating expiration flag -- end");
						}else {
							if (expirationDateForTest != null) {
								LOG.info("scheduling the expiration worker for test");
								final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
								Runnable task = new Runnable() {
									public void run() {
										try {
											List<Integer> param = new ArrayList<Integer>();
											param.add(testID);
											ApacheCommonsDBCP.DBCPDataSource("CALL_UPDATE_EXPIRAED_TEST_PROC", param, true, null,null);
										} catch (Exception e) {
											// TODO Auto-generated catch block
											e.printStackTrace();
										}
									}
								};
								final LocalDateTime now = LocalDateTime.now();
								scheduler.schedule(task, now.until(expirationDateForTest, ChronoUnit.MILLIS),
										TimeUnit.MILLISECONDS);
								// scheduler.schedule(() -> System.out.println("It's 9pm!"),
								// now.until(expirationDateForTest, ChronoUnit.MILLIS),
								// TimeUnit.MILLISECONDS);
							}
						}
					}
				}
			} catch (Exception e) {
				LOG.error("Error in executeSchedulerWorkerScheduleAtSpecificTime() method", e);
			}

		}
	}

}
