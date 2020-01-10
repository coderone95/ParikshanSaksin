package com.codesvila.datasource;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.codesvila.action.DashboardManipulationBean;
import com.codesvila.bean.AttendedTestDetailsBean;
import com.codesvila.bean.FunctionalityBO;
import com.codesvila.bean.GroupBO;
import com.codesvila.bean.GroupsTestInfoBO;
import com.codesvila.bean.QuestionsGroupBO;
import com.codesvila.bean.TestAuthBean;
import com.codesvila.bean.TestBO;
import com.codesvila.bean.UserBean;
import com.codesvila.bean.UserMasterBO;
import com.codesvila.bo.QuestionInfoBO;
import com.codesvila.utils.CommonUtility;

public class ResultBeans {

	public static List<UserBean> generateResultUserBean(ResultSet rs) throws Exception {
		List<UserBean> userBean = new ArrayList<UserBean>();
		while (rs.next()) {
			UserBean u = new UserBean();
			u.setEmail_id(rs.getString("email_id"));
			u.setPassword(rs.getString("password"));
			u.setName(rs.getString("name"));
			u.setPhone_number(rs.getString("phone_number"));
			u.setCreated_on(rs.getString("created_on"));
			u.setUpdated_on(rs.getString("updated_on"));
			u.setIs_deleted(rs.getInt("is_deleted"));
			u.setIs_disabled(rs.getInt("is_disabled"));
			u.setUser_type(rs.getString("user_type"));
			u.setUser_id(rs.getInt("user_id"));
			userBean.add(u);
		}

		return userBean;
	}

	public static List<UserBean> generateResultUserBean(List data) throws Exception {
		List<UserBean> userBean = new ArrayList<UserBean>();
		for (Object object : data) {
			Map row = (Map) object;
			UserBean u = new UserBean();
			u.setUser_type((String) row.get("user_type"));
			u.setUser_id((Integer) row.get("user_id"));
			u.setEmail_id((String) row.get("email_id"));
			u.setPassword((String) row.get("password"));
			u.setName((String) row.get("name"));
			u.setPhone_number((String) row.get("phone_number"));
			u.setIs_disabled(CommonUtility.booleanToInteger(((Boolean) row.get("is_disabled")).booleanValue()));
			u.setIs_deleted(CommonUtility.booleanToInteger(((Boolean) row.get("is_deleted")).booleanValue()));
			u.setCreated_on(row.get("created_on").toString());
			u.setUpdated_on(row.get("updated_on").toString());
			userBean.add(u);
		}

		return userBean;
	}

	public static List<QuestionInfoBO> generateResultQuestionInfoBO(List data) throws Exception {
		// TODO Auto-generated method stub
		List<QuestionInfoBO> qinfo = new ArrayList<QuestionInfoBO>();
		for (Object object : data) {
			Map row = (Map) object;
			QuestionInfoBO qb = new QuestionInfoBO();
			qb.setQuestion_id((Integer) row.get("question_id"));
			qb.setQuestion((String) row.get("question"));
			qb.setAnswer((String) row.get("option_value"));
			qb.setOption((String) row.get("option_value"));
			qb.setOptionId((Integer) row.get("option_id"));
			qb.setQuestion_createdBy(row.get("created_by").toString());
			qb.setQuestion_updatedBy(row.get("updated_by").toString());
			qb.setQuestion_createdOn(row.get("created_on").toString());
			qb.setQuestion_updatedOn(row.get("updated_on").toString());
			qinfo.add(qb);
		}
		return qinfo;

	}

	public static List<UserMasterBO> generateResultUserMasterBean(ResultSet rs) throws Exception {
		List<UserMasterBO> userMasterBean = new ArrayList<UserMasterBO>();

		while (rs.next()) {
			UserMasterBO u = new UserMasterBO();
			u.setUser_type_id(rs.getInt("user_type_id"));
			u.setUser_type(rs.getString("user_type"));
			u.setIsManagment_User(rs.getInt("isManagment_User"));
			userMasterBean.add(u);
		}

		return userMasterBean;
	}

	public static DashboardManipulationBean getDashboardCounts(ResultSet rs) throws Exception {
		DashboardManipulationBean dashCounts = new DashboardManipulationBean();
		while (rs.next()) {
			dashCounts.setTotalCandidateCount(rs.getString("totalCandidateCount"));
			dashCounts.setTotalAdminCount(rs.getString("totalAdminCount"));
			dashCounts.setTotalQuestionsCount(rs.getString("totalQuestionsCount"));
		}
		return dashCounts;
	}

	public static List<QuestionInfoBO> generateResultQuestionInfoBO(ResultSet rs) throws SQLException {
		// TODO Auto-generated method stub
		List<QuestionInfoBO> qinfo = new ArrayList<QuestionInfoBO>();
		while (rs.next()) {
			QuestionInfoBO qb = new QuestionInfoBO();
			qb.setQuestion_id(rs.getInt("questionID"));
			qb.setQuestion(rs.getString("question"));
			qb.setAnswer(rs.getString("answer"));
			qb.setQuestion_createdBy(rs.getString("createdBy"));
			qb.setQuestion_updatedBy(rs.getString("updatedBy"));
			qb.setQuestion_createdOn(rs.getString("createdOn"));
			qb.setQuestion_updatedOn(rs.getString("updatedOn"));
			// qb.setOptionId(rs.getInt("option_id"));
			// qb.setOption(rs.getString("option"));
			qinfo.add(qb);
		}
		return qinfo;
	}

	public static List<QuestionInfoBO> generateResultForGetOptionsForQuestions(ResultSet rs) throws SQLException {
		List<QuestionInfoBO> qinfo = new ArrayList<QuestionInfoBO>();
		while (rs.next()) {
			QuestionInfoBO qb = new QuestionInfoBO();
			qb.setOptionId(rs.getInt("option_id"));
			qb.setOption(rs.getString("option_value"));
			qinfo.add(qb);
		}
		return qinfo;
	}

	public static List<QuestionInfoBO> generateResultForGetQuestionWithAnswer(ResultSet rs) throws SQLException {
		List<QuestionInfoBO> qinfo = new ArrayList<QuestionInfoBO>();
		while (rs.next()) {
			QuestionInfoBO qb = new QuestionInfoBO();
			qb.setQuestion(rs.getString("question"));
			qb.setAnswer(rs.getString("answer"));
			qinfo.add(qb);
		}
		return qinfo;
	}

	public static List<GroupBO> generateResultForGroupBO(List data) throws SQLException {
		List<GroupBO> groupInfo = new ArrayList<GroupBO>();
		for (Object object : data) {
			Map row = (Map) object;
			GroupBO gp = new GroupBO();
			gp.setGroup_id((Integer) row.get("group_id"));
			gp.setGroup_name((String) row.get("group_name"));
			gp.setCreated_by((String) row.get("created_by"));
			gp.setUpdated_by((String) row.get("updated_by"));
			gp.setCreated_on(row.get("created_on").toString());
			gp.setUpdated_on(row.get("updated_on").toString());
			groupInfo.add(gp);
		}

		return groupInfo;
	}
	
	public static List<GroupBO> generateResultForGroupBO(ResultSet rs) throws SQLException {
		List<GroupBO> groupInfo = new ArrayList<GroupBO>();
		while (rs.next()) {
			GroupBO gp = new GroupBO();
			gp.setGroup_id(rs.getInt("group_id"));
			gp.setGroup_name(rs.getString("group_name"));
			gp.setCreated_by(rs.getString("created_by"));
			gp.setCreated_on(rs.getString("created_on"));
			gp.setUpdated_by(rs.getString("updated_by"));
			gp.setUpdated_on(rs.getString("updated_on"));
			groupInfo.add(gp);
		}
		return groupInfo;
	}
	
	
	public static List<QuestionsGroupBO> generateResultForQuestionsOfGroupBO(List data) {
		List<QuestionsGroupBO> QuestionGroupInfo = new ArrayList<QuestionsGroupBO>();
		for (Object object : data) {
			Map row = (Map) object;
			QuestionsGroupBO gp = new QuestionsGroupBO();
			gp.setGroup_id((Integer) row.get("id"));
			gp.setGroup_id((Integer) row.get("group_id"));
			gp.setQuestion_id((Integer) row.get("question_id"));
			gp.setQuestion((String) row.get("question"));
			QuestionGroupInfo.add(gp);
		}
		return QuestionGroupInfo;
	}

	public static List<QuestionsGroupBO> generateResultForQuestionsOfGroupBO(ResultSet rs) throws SQLException {
		List<QuestionsGroupBO> QuestionGroupInfo = new ArrayList<QuestionsGroupBO>();
		while (rs.next()) {
			QuestionsGroupBO qs = new QuestionsGroupBO();
			qs.setId(rs.getInt("id"));
			qs.setGroup_id(rs.getInt("group_id"));
			qs.setQuestion_id(rs.getInt("question_id"));
			QuestionGroupInfo.add(qs);
		}
		return QuestionGroupInfo;
	}

	public static List<QuestionsGroupBO> generateResultForGetDetailsForSelectedGroupQuestionsBO(ResultSet rs)
			throws SQLException {
		List<QuestionsGroupBO> QuestionGroupInfo = new ArrayList<QuestionsGroupBO>();
		while (rs.next()) {
			QuestionsGroupBO qs = new QuestionsGroupBO();
			qs.setQuestion(rs.getString("question"));
			qs.setQuestion_id(rs.getInt("question_id"));
			QuestionGroupInfo.add(qs);
		}
		return QuestionGroupInfo;
	}

	public static List<TestBO> generateResultTestBO(List data) {
		List<TestBO> testBo = new ArrayList<TestBO>();
		for (Object object : data) {
			Map row = (Map) object;
			TestBO tb = new TestBO();
			tb.setTest_id((Integer) row.get("test_id"));
			tb.setTest_name((String) row.get("test_name"));
			tb.setOrg_id((Integer) row.get("org_id"));
			tb.setTest_key((String) row.get("test_key"));
			tb.setAccess_key((String) row.get("access_key"));
			tb.setTest_instructions((String) row.get("test_instructions"));
			tb.setIs_live(CommonUtility.booleanToInteger(((Boolean) row.get("is_live")).booleanValue()));
			tb.setIs_disabled(CommonUtility.booleanToInteger(((Boolean) row.get("is_disabled")).booleanValue()));
			tb.setCreated_on(row.get("created_on").toString());
			tb.setUpdated_on(row.get("updated_on").toString());
			tb.setCreated_by((String) row.get("created_by"));
			tb.setUpdated_by((String) row.get("updated_by"));
			testBo.add(tb);
		}
		return testBo;
	}

	public static List<TestBO> generateResultTestBO(ResultSet rs) throws Exception{
		// TODO Auto-generated method stub
		List<TestBO> testBo = new ArrayList<TestBO>();
		while (rs.next()) {
			TestBO tb = new TestBO();
			tb.setTest_id(rs.getInt("test_id"));
			tb.setTest_name(rs.getString("test_name"));
			tb.setOrg_id(rs.getInt("org_id"));
			tb.setTest_key(rs.getString("test_key"));
			tb.setAccess_key(rs.getString("access_key"));
			tb.setTest_instructions(rs.getString("test_instructions"));
			tb.setIs_live(rs.getInt("is_live"));
			tb.setIs_disabled(rs.getInt("is_disabled"));
			tb.setCreated_on(rs.getString("created_on"));
			tb.setUpdated_on(rs.getString("updated_on"));
			tb.setCreated_by(rs.getString("created_by"));
			tb.setUpdated_by(rs.getString("updated_by"));
			tb.setTest_time(rs.getInt("test_time"));
			tb.setPassingCriteria(rs.getInt("passingCriteria"));
			tb.setStartOn(rs.getString("startOn"));
			tb.setEndOn(rs.getString("endOn"));
			testBo.add(tb);
		}
		return testBo;
	}

	public static List<GroupsTestInfoBO> generateResultForAddedGroupsForSelectedTest(ResultSet rs) throws Exception{
		// TODO Auto-generated method stub
		List<GroupsTestInfoBO> gtinfo = new ArrayList<GroupsTestInfoBO>();
		while (rs.next()) {
			GroupsTestInfoBO tb = new GroupsTestInfoBO();
			tb.setGroup_id(rs.getInt("group_id"));
			tb.setGroup_name(rs.getString("group_name"));
			gtinfo.add(tb);
		}
		return gtinfo;
	}

	public static List<TestAuthBean> generateResultForGettingKeysAndAccess(ResultSet rs) throws Exception{
		List<TestAuthBean> testAuthBean = new ArrayList<TestAuthBean>();
		while (rs.next()) {
			TestAuthBean tb = new TestAuthBean();
			tb.setTestID(rs.getInt("test_id"));
			tb.setTestKey(rs.getString("test_key"));
			tb.setAccessKey(rs.getString("access_key"));
			tb.setTest_instructions(rs.getString("test_instructions"));
			testAuthBean.add(tb);
		}
		return testAuthBean;
	}

	public static List<GroupBO> generateResultForGroupsAndNoOfQuestions(ResultSet rs) throws Exception {
		List<GroupBO> groupBo = new ArrayList<GroupBO>();
		while (rs.next()) {
			GroupBO gbo = new GroupBO();
			gbo.setGroup_id(rs.getInt("group_id"));
			gbo.setGroup_name(rs.getString("group_name"));
			gbo.setNumberOfQuestionsCount(rs.getInt("totalQuestions"));
			groupBo.add(gbo);
		}
		return groupBo;
	}

	public static List<TestBO> generateResultForGetTestNameAndTime(ResultSet rs) throws Exception{
		List<TestBO> testBo = new ArrayList<TestBO>();
		while (rs.next()) {
			TestBO tb = new TestBO();
			tb.setTest_name(rs.getString("test_name"));
			tb.setTest_time(rs.getInt("test_time"));
			testBo.add(tb);
		}
		return testBo;
	}

	public static List<AttendedTestDetailsBean> generateResultForgetAllAttendedTestDetails(ResultSet rs) throws Exception{
		List<AttendedTestDetailsBean> testBo = new ArrayList<AttendedTestDetailsBean>();
		while (rs.next()) {
			AttendedTestDetailsBean tb = new AttendedTestDetailsBean();
			tb.setId(rs.getInt("id"));
			tb.setTest_id(rs.getInt("test_id"));
			tb.setOrg_id(rs.getInt("org_id"));
			tb.setUser_id(rs.getString("user_id"));
			tb.setTest_started_time(rs.getString("test_started_time"));
			tb.setTest_ended_time(rs.getString("test_ended_time"));
			tb.setAttempted(rs.getInt("attempted"));
			tb.setMax_attempt(rs.getInt("max_attempt"));
			tb.setTest_key(rs.getString("test_key"));
			testBo.add(tb);
		}
		return testBo;
	}
	
	public static List<FunctionalityBO> generateResultForGetAllAccessRightsInfo(ResultSet rs) throws Exception{
		List<FunctionalityBO> fbo = new ArrayList<FunctionalityBO>();
		while (rs.next()) {
			AttendedTestDetailsBean tb = new AttendedTestDetailsBean();
			FunctionalityBO bo = new FunctionalityBO();
			bo.setFunctionality_id(rs.getInt("functionality_id"));
			bo.setUser_id(rs.getInt("user_id"));
			bo.setUser_type(rs.getString("user_type")); 
			bo.setFunctionality_name(rs.getString("functionality_name"));
			bo.setFunctionality_code(rs.getString("functionality_code"));
			fbo.add(bo);
		}
		return fbo;
	}

}
