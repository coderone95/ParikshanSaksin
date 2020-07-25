package com.codesvila.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.codesvila.bean.TestAuthBean;
import com.codesvila.service.CandidateService;

public class TestInstructionsAction extends BaseAction{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 
	 */
	private Integer testID;
	private TestAuthBean testAuthBean;
	@Autowired
	private CandidateService candidateService;

	/**
	 * @return the testAuthBean
	 */
	public TestAuthBean getTestAuthBean() {
		return testAuthBean;
	}

	/**
	 * @param testAuthBean the testAuthBean to set
	 */
	public void setTestAuthBean(TestAuthBean testAuthBean) {
		this.testAuthBean = testAuthBean;
	}

	/**
	 * @return the testID
	 */
	public Integer getTestID() {
		return testID;
	}

	/**
	 * @param testID the testID to set
	 */
	public void setTestID(Integer testID) {
		this.testID = testID;
	}
	
	public String getTestInstructions() throws Exception{
		List<TestAuthBean> authBean = candidateService.getAllTestKeyAccess();
		for(TestAuthBean b : authBean) {
			if(testID == b.getTestID()) {
				testAuthBean.setTest_instructions(b.getTest_instructions());
				return "success";
			}
		}
		return "success";
	}
	
}
