package com.codesvila.schedular;

import com.codesvila.schedular.workers.Worker;

public interface ScheduleWorker {
	
	public Worker getScheduleWorker() throws Exception;
}
