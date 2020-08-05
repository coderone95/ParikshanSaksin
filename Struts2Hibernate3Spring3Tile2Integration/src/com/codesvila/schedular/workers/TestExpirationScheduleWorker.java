package com.codesvila.schedular.workers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.codesvila.action.Generic;
import com.codesvila.bean.TestBO;
import com.codesvila.datasource.ApacheCommonsDBCP;
import com.codesvila.schedular.ScheduleWorker;

public class TestExpirationScheduleWorker  extends Worker implements ScheduleWorker{
	
	public String name;
	
	@Override
	public Worker getScheduleWorker() throws Exception {
		// TODO Auto-generated method stub
		Worker worker = new Worker();
		Map<String,Object> scheduleParams = new HashMap<>();
		List<TestBO> testsBO = new ArrayList<>();
		try {
			testsBO = getExpirationDateAndTestID();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		scheduleParams.put("testsBO", testsBO);
		worker.setScheduleType("scheduleAtSpecificTime");
		worker.setScheduleParams(scheduleParams);
		worker.setWorkerName("TestExpirationScheduleWorker");
		return worker;
	}

	private List<TestBO> getExpirationDateAndTestID() throws Exception {
		// TODO Auto-generated method stub
		List<TestBO> tests = new ArrayList<>();
		StringBuilder query = new StringBuilder();
		query.append("SELECT test_id, endOn FROM tbl_tests");
		
		Generic genricDao = new Generic();
		List<Object[]> resultList = genricDao.nativeSQLQueryForList(query.toString());
		tests = extractResult(resultList);
		return tests;
	}

	private List<TestBO> extractResult(List<Object[]> resultList) throws Exception {
		// TODO Auto-generated method stub
		List<TestBO> tests = new ArrayList<>();
		@SuppressWarnings("unchecked")
		List<TestBO> testBOs = ApacheCommonsDBCP.DBCPDataSource("GET_ALL_TESTS", null, false, null,null);
//		for(Object [] obj : resultList) {
//			TestBO test = new TestBO();
//			if(obj != null) {
//				Integer testID = (Integer) obj[0];
//				test.setTest_id(testID);
//				test.setEndOn((String) obj[1]);
//				tests.add(test);
//			}
//		}
		if(testBOs != null && testBOs.size() > 0) {
			for(TestBO t : testBOs) {
				TestBO test = new TestBO();
				test.setEndOn(t.getEndOn());
				test.setTest_id(t.getTest_id());
			}
		}
		return testBOs;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
