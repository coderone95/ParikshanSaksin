package com.codesvila.schedular.workers;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class Worker {
	
	public String workerName;
	public String scheduleType;
	public Map<String,Object> scheduleParams;
	public String getScheduleType() {
		return scheduleType;
	}
	public void setScheduleType(String scheduleType) {
		this.scheduleType = scheduleType;
	}
	public Map<String, Object> getScheduleParams() {
		return scheduleParams;
	}
	public void setScheduleParams(Map<String, Object> scheduleParams) {
		this.scheduleParams = scheduleParams;
	}
	public String getWorkerName() {
		return workerName;
	}
	public void setWorkerName(String workerName) {
		this.workerName = workerName;
	}
	
	public List<Worker> getAllWorkers() throws Exception{
		List<Worker> allworkers = new ArrayList<>();
		allworkers.add(new TestExpirationScheduleWorker().getScheduleWorker());
		return allworkers;
	}
}
