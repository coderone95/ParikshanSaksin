package com.codesvila.datasource;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import com.codesvila.action.DashboardManipulationBean;
import com.codesvila.action.Generic;
import com.codesvila.bean.AttendedTestDetailsBean;
import com.codesvila.bean.FunctionalityBO;
import com.codesvila.bean.GroupBO;
import com.codesvila.bean.GroupsTestInfoBO;
import com.codesvila.bean.OTPBO;
import com.codesvila.bean.QuestionBO;
import com.codesvila.bean.QuestionsGroupBO;
import com.codesvila.bean.TestAuthBean;
import com.codesvila.bean.TestBO;
import com.codesvila.bean.UserBean;
import com.codesvila.bean.UserMasterBO;
import com.codesvila.bo.QueryMapperBO;
import com.codesvila.bo.QuestionInfoBO;
import com.codesvila.dao.mapper.Mapper;
import com.codesvila.utils.searches.ParamBO;
import com.codesvila.utils.searches.SearchReport;
import com.opensymphony.xwork2.ActionSupport;

public class ApacheCommonsDBCP extends ActionSupport{

	public static Map getDataInMap(String queryId, List listObj, boolean isParamsAvailable) throws Exception {
		DataSource ds = DBCPDataSourceFactory.getDataSource();
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
//		LOG.info("Query---- :\n" + query);
		try {
			con = ds.getConnection();
			stmt = con.createStatement();
			if (queryId.equals("GET_DASHBOARDS_CANDIDATE_COUNT")) {
				StringBuilder params = new StringBuilder();
				String query = null;
				query = "select count(user_id) as totalCandidateCount, 0 as totalAdminCount, 0 as totalQuestionsCount from tbl_users where user_type in('CANDIDATE')";
				LOG.info("Query---- :\n" + query);
				Map<String, String> map = new HashMap<String, String>();
				rs = stmt.executeQuery(query);
				DashboardManipulationBean counts = new DashboardManipulationBean();
				if (rs != null) {
					counts = ResultBeans.getDashboardCounts(rs);
					if (counts != null) {
						map.put("totalCandidateCount", counts.getTotalCandidateCount());
					}
				}
				return map;
			} else if (queryId.equals("GET_DASHBOARDS_ADMIN_COUNT")) {
				StringBuilder params = new StringBuilder();
				String query = null;
				query = "select 0 as totalCandidateCount, count(user_id) as totalAdminCount, 0 as totalQuestionsCount from tbl_users where user_type in('ADMIN')";
				LOG.info("Query---- :\n" + query);
				Map<String, String> map = new HashMap<String, String>();
				rs = stmt.executeQuery(query);
				DashboardManipulationBean counts = new DashboardManipulationBean();
				if (rs != null) {
					counts = ResultBeans.getDashboardCounts(rs);
					if (counts != null) {
						map.put("totalAdminCount", counts.getTotalAdminCount());
					}
				}
				return map;
			} else if (queryId.equals("GET_DASHBOARDS_QUESTIONS_COUNT")) {
				StringBuilder params = new StringBuilder();
				String query = null;
				query = "select 0 as totalCandidateCount, 0 as totalAdminCount, count(1) as totalQuestionsCount from tbl_questions";
				LOG.info("Query---- :\n" + query);
				Map<String, String> map = new HashMap<String, String>();
				rs = stmt.executeQuery(query);
				DashboardManipulationBean counts = new DashboardManipulationBean();
				if (rs != null) {
					counts = ResultBeans.getDashboardCounts(rs);
					if (counts != null) {
						map.put("totalQuestionsCount", counts.getTotalQuestionsCount());
					}
				}
				return map;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (con != null)
					con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	public static StringBuilder stringParams(List list) {
		String commaSeperator = ",";
		String stringSep = "'";
		StringBuilder sb = new StringBuilder();
		for (Object li : list) {
			String temp = (String) li;
			sb.append(stringSep);
			sb.append(temp);
			sb.append(stringSep);
			int index = list.indexOf(li);
			if (index != (list.size() - 1)) {
				sb.append(commaSeperator);
			}
		}
		return sb;
	}

	public static StringBuilder intParams(List list) {
		String commaSeperator = ",";
		StringBuilder sb = new StringBuilder();
		for (Object li : list) {
			Integer temp = (Integer) li;
			sb.append(temp);
			int index = list.indexOf(li);
			if (index != (list.size() - 1)) {
				sb.append(commaSeperator);
			}
		}
		return sb;
	}
	
	public static List CandidateDBCPDataSource(String queryId,boolean isParamsAvailable,
			Map<String, Object> paramMap) throws Exception {
		DataSource ds = DBCPDataSourceFactory.getDataSource();
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			stmt = con.createStatement();
			if (queryId.equals("GET_ALL_TEST_KEY_ACCESS_INFO")) {
				StringBuilder params = new StringBuilder();
				String query = null;
				query = "select test_id, test_key, access_key, test_instructions from tbl_tests";
				LOG.info("Query---- :\n" + query);
				List<TestAuthBean> testKeysAndAccess = new ArrayList<TestAuthBean>();
				rs = stmt.executeQuery(query);
				if (rs != null) {
					testKeysAndAccess = ResultBeans.generateResultForGettingKeysAndAccess(rs); 
				}
				return testKeysAndAccess;
			}else if (queryId.equals("GET_TEST_GROUP_NO_OF_QUESTIONS_COUNT")) {
				StringBuilder params = new StringBuilder();
				Integer testID = (Integer) paramMap.get("testID");
				String query = null;
				query = "select g.group_id, g.group_name, count(1) as totalQuestions from tbl_questions_group qg inner join tbl_groups g on g.group_id = qg.group_id where qg.group_id in "
						+ "(select group_id from (select t.test_id, t.test_name, t.test_time, gt.group_id from tbl_tests t inner join tbl_groups_test gt on t.test_id = gt.test_id ) temp12 "
						+ "where test_id in ("+testID+") ) group by qg.group_id";
				LOG.info("Query---- :\n" + query);
				List<GroupBO> GroupsAndNoOfQuestions = new ArrayList<GroupBO>();
				rs = stmt.executeQuery(query);
				if (rs != null) {
					GroupsAndNoOfQuestions = ResultBeans.generateResultForGroupsAndNoOfQuestions(rs); 
				}
				return GroupsAndNoOfQuestions;
				
			}else if (queryId.equals("GET_TEST_NAME_AND_TIME")) {
				StringBuilder params = new StringBuilder();
				Integer testID = (Integer) paramMap.get("testID");
				String query = null;
				query = "select test_name, test_time from tbl_tests where test_id in ("+testID+")";
				LOG.info("Query---- :\n" + query);
				List<TestBO> testInfo = new ArrayList<TestBO>();
				rs = stmt.executeQuery(query);
				if (rs != null) {
					testInfo = ResultBeans.generateResultForGetTestNameAndTime(rs); 
				}
				return testInfo;
			}else if(queryId.equals("GET_ALL_ATTENDED_TEST_DETAILS")) {
				String query = null;
//				query = "select id, test_id, org_id, user_id, test_started_time, test_ended_time,attempted,max_attempt from tbl_attended_test_details";
				query = "select atd.id, atd.test_id, atd.org_id, t.test_key, atd.user_id, atd.attempted,atd.max_attempt "
						+ "from tbl_attended_test_details atd " + 
						"inner join tbl_tests t on t.test_id = atd.test_id ";
				LOG.info("Query---- :\n" + query);
				List<AttendedTestDetailsBean> testInfo = new ArrayList<AttendedTestDetailsBean>();
				rs = stmt.executeQuery(query);
				if (rs != null) {
					testInfo = ResultBeans.generateResultForgetAllAttendedTestDetails(rs); 
				}
				return testInfo;
			}else if(queryId.equals("GET_QUESTION_ONLY")) {
				Integer quesID = null;
				List<QuestionBO> quesList = new ArrayList<QuestionBO>();
				if(paramMap != null) {
					quesID = (Integer) paramMap.get("QuestionID");
				}
				if(quesID !=null) {
					StringBuffer query = new StringBuffer();
					query.append("SELECT q.question, q.question_type FROM tbl_questions q ");
					query.append(" Where q.question_id = ").append(quesID);
					rs = stmt.executeQuery(query.toString());
					LOG.info("Query---- GET_QUESTION_ONLY:\n" + query.toString());
					if(rs !=null) {
						QuestionBO qbo = ResultBeans.convertVoToBoForQuestionBO(rs);
						if(qbo !=null) {
							quesList.add(qbo);
						}
					}
				}
				return quesList;
			}else if(queryId.equals("GET_OPTIONS_ONLY")) {
				Integer quesID = null;
				
				List<QuestionInfoBO> optionList = new ArrayList<QuestionInfoBO>();
				if(paramMap != null) {
					quesID = (Integer) paramMap.get("QuestionID");
				}
				if(quesID !=null) {
					StringBuffer query = new StringBuffer();
					query.append("SELECT qo.option_id, qo.option_value FROM tbl_que_options qo ");
					query.append(" WHERE qo.question_id = ").append(quesID);
					rs = stmt.executeQuery(query.toString());
					LOG.info("Query---- GET_OPTIONS_ONLY:\n" + query.toString());
					if(rs !=null) {
						optionList = ResultBeans.generateResultForGetOptionsForQuestions(rs);
					}
				}
				return optionList;
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (con != null)
					con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	@SuppressWarnings("unused")
	public static List DBCPDataSource(String queryId, List listObj, boolean isParamsAvailable,
			Map<String, Object> paramMap, Integer singleParam) throws Exception {
		DataSource ds = DBCPDataSourceFactory.getDataSource();
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;

		QueryMapperBO mp = new QueryMapperBO();
		Generic generic = new Generic();
		List data = null;

		try {
			con = ds.getConnection();
			stmt = con.createStatement();
			if (queryId.equals("GET_USERS")) {
				StringBuilder params = new StringBuilder();
				String query = null;
				if (isParamsAvailable) {
					if (listObj != null) {
						params = stringParams(listObj);
						// emails = intParams(listObj);
						query = "select * from tbl_users where user_id in (" + params.toString() + ")";
						LOG.info("Query---- :\n" + query);
					}
				} else {
					// query = "select * from tbl_users order by 1 desc";
					mp = Mapper.getQuery(queryId);
					if (mp != null) {
						query = mp.getQuery();
						data = generic.nativeSQLQueryList(query);
					}
					LOG.info("Query---- :\n" + query);
				}

				// rs = stmt.executeQuery(query);

				List<UserBean> ub = new ArrayList<UserBean>();
				if (data != null) {
					ub = ResultBeans.generateResultUserBean(data);
				}
				return ub;
			} else if (queryId.equals("GET_USER_PROFILE_DATA")) {

				Map<String, ParamBO> myparamBO = new HashMap<String,ParamBO>();
				
				String email = (String) paramMap.get("email");
				Integer userId = (Integer) paramMap.get("userId");
				
				ParamBO pEmailId = new ParamBO();
				pEmailId.setParamName("pEmailId");
				pEmailId.setParamType("SingleParamElement");
				pEmailId.setParamreturnType("String");
				pEmailId.setParamValue(email);
				
				ParamBO pUserId = new ParamBO();
				pUserId.setParamName("pUserId");
				pUserId.setParamType("SingleParamElement");
				pUserId.setParamreturnType("Integer");
				pUserId.setParamValue(userId);
				
				myparamBO.put("pEmailId", pEmailId);
				myparamBO.put("pUserId", pUserId);
				QueryMapperBO qmbo = SearchReport.getQuery("GET_USER_PROFILE_DATA","QueryMapper",myparamBO);
//				LOG.info("Query from qmbo \t\t\t:::::"+ qmbo.getQuery());
				LOG.info("emails " + email);
				//String query = "select * from tbl_users where email_id in (" + email.toString() + ") limit 1";
				//LOG.info("Query---- :\n" + query);

				if (qmbo.getQuery() != null) {
//					data = generic.nativeSQLQueryList(qmbo.getQuery());
					rs = stmt.executeQuery(qmbo.getQuery());
				}
				List<UserBean> ub = new ArrayList<UserBean>();
				if (rs != null) {
					ub = ResultBeans.generateResultUserBean(rs);
				}
				return ub;
			} else if (queryId.equals("GET_MASTER_USER_DETAILS")) {
				StringBuilder userType = new StringBuilder();
				if (listObj != null) {
					userType = stringParams(listObj);
				}

				LOG.info("userType " + userType);
				String query = "select * from tbl_mst_user_type where user_type in (" + userType.toString()
						+ ") limit 1";
				LOG.info("userType Query :::" + query);
				rs = stmt.executeQuery(query);
				List<UserMasterBO> ub = new ArrayList<UserMasterBO>();
				if (rs != null) {
					ub = ResultBeans.generateResultUserMasterBean(rs);
				}
				return ub;
			} else if (queryId.equals("GET_CANDIDATE_USERS")) {
				String query = "select * from tbl_users where user_type in ('CANDIDATE')";
				rs = stmt.executeQuery(query);
				List<UserBean> ub = new ArrayList<UserBean>();
				if (rs != null) {
					ub = ResultBeans.generateResultUserBean(rs);
				}
				return ub;
			} else if (queryId.equals("GET_ALL_QUESTIONS")) {
				String query = "select q.question_id as questionID, q.group_id, q.question as question , q.question_type as questionType,'' as answer,"
						+ "q.created_by as createdBy, q.updated_by as updatedBy, q.created_on as createdOn, q.updated_on as updatedOn "
						+ " from tbl_questions q";

				LOG.info(" Returned Query :::\n\n\n\n" + query);
				rs = stmt.executeQuery(query);
				List<QuestionInfoBO> qi = new ArrayList<QuestionInfoBO>();
				if (rs != null) {
					qi = ResultBeans.generateResultQuestionInfoBO(rs);
				}
				return qi;
			} else if (queryId.equals("CALL_DELETE_QUESTION_PROC")) {
				Integer questionId = null;
				String proceQuery = null;
				if (listObj != null && isParamsAvailable) {
					for (Object o : listObj) {
						questionId = (Integer) o;
						break;
					}
				}
				if (questionId != null) {
					proceQuery = "call deleteQuestionWithOptions(" + questionId + ");";
					rs = stmt.executeQuery(proceQuery);
				}
				return null;
			}else if (queryId.equals("CALL_UPDATE_EXPIRAED_TEST_PROC")) {
				Integer testID = null;
				String proceQuery = null;
				if (listObj != null && isParamsAvailable) {
					for (Object o : listObj) {
						testID = (Integer) o;
						break;
					}
				}
				if (testID != null) {
					proceQuery = "call updateExpiredTest(" + testID + ");";
					rs = stmt.executeQuery(proceQuery);
				}
				return null;
			}else if (queryId.equals("GET_OPTIONS_FOR_QUESTION")) {
				Integer questionId = null;
				String query = null;
				if (listObj != null && isParamsAvailable) {
					for (Object o : listObj) {
						questionId = (Integer) o;
						break;
					}
				}
				query = "select option_id, option_value from tbl_que_options where question_id = " + questionId + ";";
				LOG.info("query for : GET_OPTIONS_FOR_QUESTION " + query);
				if (questionId != null) {
					rs = stmt.executeQuery(query);
				}
				List<QuestionInfoBO> qi = new ArrayList<QuestionInfoBO>();
				// List<String> optionList = new ArrayList<String>();
				if (rs != null) {
					qi = ResultBeans.generateResultForGetOptionsForQuestions(rs);
				}
				return qi;
			} else if (queryId.equals("GET_QUESTION_WITH_ANSWER")) {
				Integer questionId = null;
				String query = null;
				if (listObj != null && isParamsAvailable) {
					for (Object o : listObj) {
						questionId = (Integer) o;
						break;
					}
				}
				query = "select q.question as question , q.question_type as questionType, o.option_value as answer from tbl_questions q inner join tbl_que_options o on\n"
						+ "q.question_id = o.question_id\n" + "where q.question_id =  " + questionId
						+ " and o.isCorrect = 1";
				LOG.info("query for : GET_QUESTION_WITH_ANSWER " + query);
				if (questionId != null) {
					rs = stmt.executeQuery(query);
				}
				List<QuestionInfoBO> qi = new ArrayList<QuestionInfoBO>();
				if (rs != null) {
					qi = ResultBeans.generateResultForGetQuestionWithAnswer(rs);
				}

				return qi;
			} else if (queryId.equals("GET_GROUPS")) {
				String query = "select group_id, group_name, created_on, created_by, updated_by, updated_on from tbl_groups";
				LOG.info("Query---- :\n" + query);

				if (query != null) {
					data = generic.nativeSQLQueryList(query);
				}
				List<GroupBO> gp = new ArrayList<GroupBO>();
				if (data != null) {
					gp = ResultBeans.generateResultForGroupBO(data);
				}
				return gp;
			} else if (queryId.equals("GET_ALL_ADDED_QUESTIONS_OF_GROUP")) {
				String query = null;
				query = "select id, group_id, question_id from tbl_questions_group";

				LOG.info("Query---- :\n" + query);

				if (query != null) {
					data = generic.nativeSQLQueryList(query);
				}
				List<QuestionsGroupBO> gp = new ArrayList<QuestionsGroupBO>();
				if (data != null) {
					gp = ResultBeans.generateResultForQuestionsOfGroupBO(data);
				}
				return gp;
			} else if(queryId.equals("GET_DETAILS_FOR_SELECTED_GROUP")) {
				String query = null;
				StringBuilder groupId = new StringBuilder();
				if (listObj != null) {
					groupId = intParams(listObj);
				}
				query = "select q.question_id, q.question, q.group_id from tbl_questions q where q.group_id in ("+ groupId.toString()+")";
				
				if(query != null) {
					rs = stmt.executeQuery(query);
				}
				List<QuestionsGroupBO> gp = new ArrayList<QuestionsGroupBO>();
				if(rs != null) {
					gp = ResultBeans.generateResultForGetDetailsForSelectedGroupQuestionsBO(rs);
				}
				return gp;
			}else if (queryId.equals("CALL_QUESTIONS_GROUP_DELETE_PROC")) {
				Integer groupId = null;
				String proceQuery = null;
				if (listObj != null && isParamsAvailable) {
					for (Object o : listObj) {
						groupId = (Integer) o;
						break;
					}
				}
				if (groupId != null) {
					proceQuery = "call deleteSelectedGorupWithQuestions(" + groupId + ");";
					rs = stmt.executeQuery(proceQuery);
				}
				return null;
			}
			else if(queryId.equals("CALL_DELETE_SELECTED_QUESTION_FROM_GROUP_PROC")) {
				StringBuilder params = new StringBuilder();
				String proceQuery = null;
				if (listObj != null && isParamsAvailable) {
					params = intParams(listObj);
				}
				if (params != null) {
					proceQuery = "call deleteSelectedQuestionFromGroup(" + params.toString() + ");";
					rs = stmt.executeQuery(proceQuery);
				}
				return null;
			}
			else if (queryId.equals("GET_ALL_TESTS")) {
				String query = null;
				query = "select test_id, test_name, test_time,org_id, test_key, access_key, test_instructions, "
						+ "startOn, endOn, passingCriteria, is_live, is_disabled, created_on, updated_on, created_by, updated_by from tbl_tests order by 1 desc";

				LOG.info("Query---- :\n" + query);

				if (query != null) {
					//data = generic.nativeSQLQueryList(query);
					rs = stmt.executeQuery(query);
				}
				List<TestBO> tb = new ArrayList<TestBO>();
				if (rs != null) {
					tb = ResultBeans.generateResultTestBO(rs);
				}
				return tb;
			}else if(queryId.equals("CALL_REMOVE_TEST_REC_FROM_GROUPS_TEST_TABLE")) {
				String query = null;
				StringBuilder params = new StringBuilder();
				if(listObj != null && isParamsAvailable) {
					params = intParams(listObj);
				}
				query = "delete from tbl_groups_test where test_id in ("+params.toString()+")";
				LOG.info("Query---- :\n" + query);
				int i = stmt.executeUpdate(query);
				LOG.info("Deleting the test:::---"+i);
				return null;
			}else if(queryId.equals("GET_TEST_INFO_FOR_SELECTED_ID")) {
				String query = null;
				StringBuilder params = new StringBuilder();
				if(listObj != null && isParamsAvailable) {
					params = intParams(listObj);
				}
				query = "select test_id,test_name,org_id,test_key,access_key,startOn, endOn, passingCriteria,test_time,"
						+ "test_instructions,is_live,is_disabled,created_on,updated_on,created_by,updated_by from tbl_tests where test_id in ("+params.toString()+")";
				if (query != null) {
					//data = generic.nativeSQLQueryList(query);
					rs = stmt.executeQuery(query);
				}
				List<TestBO> tb = new ArrayList<TestBO>();
				if (rs != null) {
					tb = ResultBeans.generateResultTestBO(rs);
				}
				return tb;
			}else if(queryId.equals("GET_ADDED_GROUPS_FOR_SELECTED_TEST")) {
				String query = null;
				StringBuilder params = new StringBuilder();
				if(listObj != null && isParamsAvailable) {
					params = intParams(listObj);
				}
				query = "select g.group_id, g.group_name from tbl_groups_test gt inner join tbl_groups g on g.group_id = gt.group_id where gt.test_id in ("+params.toString()+")";
				if(query !=null) {
					rs = stmt.executeQuery(query);
				}
				List<GroupsTestInfoBO> gtinfo = new ArrayList<GroupsTestInfoBO>();
				if(rs != null) {
					gtinfo = ResultBeans.generateResultForAddedGroupsForSelectedTest(rs);
				}
				return gtinfo;
			}else if(queryId.equals("GET_AVAILABLE_GROUPS_FOR_SELECTED_TEST")) {
				String query = null;
				StringBuilder params = new StringBuilder();
				if(listObj != null && isParamsAvailable) {
					params = intParams(listObj);
				}
				if(params != null) {
					query = "select g.group_id, g.group_name from tbl_groups g where g.group_id not in (select group_id from tbl_groups_test where test_id in ("+params.toString()+"))";
				}
				if(query !=null) {
					rs = stmt.executeQuery(query);
				}
				List<GroupsTestInfoBO> gtinfo = new ArrayList<GroupsTestInfoBO>();
				if(rs != null) {
					gtinfo = ResultBeans.generateResultForAddedGroupsForSelectedTest(rs);
				}
				return gtinfo;
			}else if(queryId.equals("GET_ADDED_QUESTIONS_FOR_SELECTED_GROUP")) {
				String query = null;
				StringBuilder groupId = new StringBuilder();
				if (listObj != null) {
					groupId = intParams(listObj);
				}
				query = "select q.question_id, q.question, q.group_id from tbl_questions q inner join tbl_groups g on g.group_id = q.group_id where g.group_id in ("+ groupId.toString()+")";
				
				if(query != null) {
					rs = stmt.executeQuery(query);
				}
				List<QuestionsGroupBO> gp = new ArrayList<QuestionsGroupBO>();
				if(rs != null) {
					gp = ResultBeans.generateResultForGetDetailsForSelectedGroupQuestionsBO(rs);
				}
				return gp;
			}else if(queryId.equals("GET_AVAILABLE_QUESTIONS_FOR_SELECTED_GROUP")) {
				String query = null;
				StringBuilder groupId = new StringBuilder();
				if (listObj != null) {
					groupId = intParams(listObj);
				}
				query = "select q.question_id, q.question from tbl_questions q  where q.question_id not "
						+ "in (select question_id from tbl_questions_group where group_id in ("+ groupId.toString()+"))";
				if(query != null) {
					rs = stmt.executeQuery(query);
				}
				List<QuestionsGroupBO> gp = new ArrayList<QuestionsGroupBO>();
				if(rs != null) {
					gp = ResultBeans.generateResultForGetDetailsForSelectedGroupQuestionsBO(rs);
				}
				return gp;
			}else if(queryId.equals("CALL_DELETE_SELECTED_GROUP_FROM_SELECTED_TEST_PROC")) {
				StringBuilder params = new StringBuilder();
				String proceQuery = null;
				if (listObj != null && isParamsAvailable) {
					params = intParams(listObj);
				}
				List<Integer> res = new ArrayList<Integer>();
				if (params != null) {
					proceQuery = "call deleteSelectedGroupFromSelectedTest(" + params.toString() + ");";
					int i = stmt.executeUpdate(proceQuery);
					res.add(i);
				}
				return res;
			}else if(queryId.equals("GET_QUESTIONS_REPORT")) {
				String query = null;
				Map<String, ParamBO> mymap = new HashMap<String,ParamBO>();
				String startDate = (String) paramMap.get("startDate");
				String endDate = (String) paramMap.get("endDate");
				String createdBy = (String) paramMap.get("createdBy");
				String questionName = (String) paramMap.get("questionName");
				Integer questionId = (Integer) paramMap.get("questionId");
				Integer groupId = (Integer) paramMap.get("groupId");
				
				ParamBO pStartDate = new ParamBO();
				pStartDate.setParamName("pStartDate");
				pStartDate.setParamType("SingleParamElement");
				pStartDate.setParamreturnType("String");
				pStartDate.setParamValue(startDate);
				
				ParamBO pEndDate = new ParamBO();
				pEndDate.setParamName("pEndDate");
				pEndDate.setParamType("SingleParamElement");
				pEndDate.setParamreturnType("String");
				pEndDate.setParamValue(endDate);
				
				ParamBO pCreatedBy = new ParamBO();
				pCreatedBy.setParamName("pCreatedBy");
				pCreatedBy.setParamType("SingleParamElement");
				pCreatedBy.setParamreturnType("String");
				pCreatedBy.setParamValue(createdBy);
				
				
				ParamBO pQuestionName = new ParamBO();
				pQuestionName.setParamName("pQuestionName");
				pQuestionName.setParamType("SingleParamElement");
				pQuestionName.setParamreturnType("String");
				pQuestionName.setParamValue(questionName);
				
				ParamBO pQuestionId = new ParamBO();
				pQuestionId.setParamName("pQuestionId");
				pQuestionId.setParamType("SingleParamElement");
				pQuestionId.setParamreturnType("Integer");
				pQuestionId.setParamValue(questionId);
				
				ParamBO pGroupId = new ParamBO();
				pQuestionId.setParamName("pGroupId");
				pQuestionId.setParamType("SingleParamElement");
				pQuestionId.setParamreturnType("Integer");
				pQuestionId.setParamValue(groupId);

				mymap.put("pStartDate", pStartDate);
				mymap.put("pEndDate", pEndDate);
				mymap.put("pCreatedBy", pCreatedBy);
				mymap.put("pQuestionName", pQuestionName);
				mymap.put("pQuestionId", pQuestionId);
				mymap.put("pGroupId", pGroupId);
				LOG.info("questionId \t\t\t\t \n" + questionId);
				QueryMapperBO qmbo = SearchReport.getQuery(queryId, "ReportQuery", mymap);
				LOG.info("QueryMapperBO qmbo : GET_QUESTIONS_REPORT \n\n" + qmbo.getQuery());
				query = qmbo.getQuery();
				if(query != null)
					rs = stmt.executeQuery(query);
				List<QuestionInfoBO> qi = new ArrayList<QuestionInfoBO>();
				if (rs != null) {
					qi = ResultBeans.generateResultQuestionInfoBO(rs);
				}
				return qi;
			}else if(queryId.equals("GET_GROUPS_REPORT")) {
				String query = null;
				Map<String, ParamBO> mymap = new HashMap<String,ParamBO>();
				String startDate = (String) paramMap.get("startDate");
				String endDate = (String) paramMap.get("endDate");
				String createdBy = (String) paramMap.get("createdBy");
				String groupName = (String) paramMap.get("groupName");
				Integer groupId = (Integer) paramMap.get("groupId");
				
				ParamBO pStartDate = new ParamBO();
				pStartDate.setParamName("pStartDate");
				pStartDate.setParamType("SingleParamElement");
				pStartDate.setParamreturnType("String");
				pStartDate.setParamValue(startDate);
				
				ParamBO pEndDate = new ParamBO();
				pEndDate.setParamName("pEndDate");
				pEndDate.setParamType("SingleParamElement");
				pEndDate.setParamreturnType("String");
				pEndDate.setParamValue(endDate);
				
				ParamBO pCreatedBy = new ParamBO();
				pCreatedBy.setParamName("pCreatedBy");
				pCreatedBy.setParamType("SingleParamElement");
				pCreatedBy.setParamreturnType("String");
				pCreatedBy.setParamValue(createdBy);
				
				
				ParamBO pGroupName = new ParamBO();
				pGroupName.setParamName("pGroupName");
				pGroupName.setParamType("SingleParamElement");
				pGroupName.setParamreturnType("String");
				pGroupName.setParamValue(groupName);
				
				ParamBO pGroupId = new ParamBO();
				pGroupId.setParamName("pGroupId");
				pGroupId.setParamType("SingleParamElement");
				pGroupId.setParamreturnType("Integer");
				pGroupId.setParamValue(groupId);

				mymap.put("pStartDate", pStartDate);
				mymap.put("pEndDate", pEndDate);
				mymap.put("pCreatedBy", pCreatedBy);
				mymap.put("pGroupName", pGroupName);
				mymap.put("pGroupId", pGroupId);
				LOG.info("questionId \t\t\t\t \n" + groupId);
				QueryMapperBO qmbo = SearchReport.getQuery(queryId, "ReportQuery", mymap);
				LOG.info("QueryMapperBO qmbo : GET_GROUPS_REPORT \n\n" + qmbo.getQuery());
				query = qmbo.getQuery();
				if(query != null)
					rs = stmt.executeQuery(query);
				List<GroupBO> gp = new ArrayList<GroupBO>();
				if(rs != null)
					gp = ResultBeans.generateResultForGroupBO(rs);
				return gp;
			}else if(queryId.equals("GET_TESTS_REPORT")) {
				String query = null;
				Map<String, ParamBO> mymap = new HashMap<String,ParamBO>();
				String startDate = (String) paramMap.get("startDate");
				String endDate = (String) paramMap.get("endDate");
				String createdBy = (String) paramMap.get("createdBy");
				String testName = (String) paramMap.get("testName");
				Integer testId = (Integer) paramMap.get("testId");
				String testKey = (String) paramMap.get("testKey");
				
				ParamBO pStartDate = new ParamBO();
				pStartDate.setParamName("pStartDate");
				pStartDate.setParamType("SingleParamElement");
				pStartDate.setParamreturnType("String");
				pStartDate.setParamValue(startDate);
				
				ParamBO pEndDate = new ParamBO();
				pEndDate.setParamName("pEndDate");
				pEndDate.setParamType("SingleParamElement");
				pEndDate.setParamreturnType("String");
				pEndDate.setParamValue(endDate);
				
				ParamBO pCreatedBy = new ParamBO();
				pCreatedBy.setParamName("pCreatedBy");
				pCreatedBy.setParamType("SingleParamElement");
				pCreatedBy.setParamreturnType("String");
				pCreatedBy.setParamValue(createdBy);
				
				
				ParamBO pTestName = new ParamBO();
				pTestName.setParamName("pTestName");
				pTestName.setParamType("SingleParamElement");
				pTestName.setParamreturnType("String");
				pTestName.setParamValue(testName);
				
				ParamBO pTestId = new ParamBO();
				pTestId.setParamName("pTestId");
				pTestId.setParamType("SingleParamElement");
				pTestId.setParamreturnType("Integer");
				pTestId.setParamValue(testId);
				
				ParamBO pTestKey = new ParamBO();
				pTestKey.setParamName("pTestKey");
				pTestKey.setParamType("SingleParamElement");
				pTestKey.setParamreturnType("String");
				pTestKey.setParamValue(testKey);

				mymap.put("pStartDate", pStartDate);
				mymap.put("pEndDate", pEndDate);
				mymap.put("pCreatedBy", pCreatedBy);
				mymap.put("pTestName", pTestName);
				mymap.put("pTestId", pTestId);
				mymap.put("pTestKey", pTestKey);
				QueryMapperBO qmbo = SearchReport.getQuery(queryId, "ReportQuery", mymap);
				LOG.info("QueryMapperBO qmbo : GET_TESTS_REPORT \n\n" + qmbo.getQuery());
				query = qmbo.getQuery();
				if (query != null) {
					rs = stmt.executeQuery(query);
				}
				List<TestBO> tb = new ArrayList<TestBO>();
				if (rs != null) {
					tb = ResultBeans.generateResultTestBO(rs);
				}
				return tb;
			}else if(queryId.equals("GET_USERS_REPORT")) {
				String query = null;
				Map<String, ParamBO> mymap = new HashMap<String,ParamBO>();
				String startDate = (String) paramMap.get("startDate");
				String endDate = (String) paramMap.get("endDate");
				String userName = (String) paramMap.get("userName");
				String phoneNumber = (String) paramMap.get("phoneNumber");
				Integer userId = (Integer) paramMap.get("userId");
				String emailId = (String) paramMap.get("emailId");
				String userType = (String) paramMap.get("userType");
				String loggedInUserId = (String) paramMap.get("loggedInUserId");
				List<String> notAllowedToSearchList = (List<String>) paramMap.get("notAllowedToSearchList");
				
				ParamBO pStartDate = new ParamBO();
				pStartDate.setParamName("pStartDate");
				pStartDate.setParamType("SingleParamElement");
				pStartDate.setParamreturnType("String");
				pStartDate.setParamValue(startDate);
				
				ParamBO pEndDate = new ParamBO();
				pEndDate.setParamName("pEndDate");
				pEndDate.setParamType("SingleParamElement");
				pEndDate.setParamreturnType("String");
				pEndDate.setParamValue(endDate);
				
				ParamBO pUserName = new ParamBO();
				pUserName.setParamName("pUserName");
				pUserName.setParamType("SingleParamElement");
				pUserName.setParamreturnType("String");
				pUserName.setParamValue(userName);
				
				
				ParamBO pPhoneNumber = new ParamBO();
				pPhoneNumber.setParamName("pPhoneNumber");
				pPhoneNumber.setParamType("SingleParamElement");
				pPhoneNumber.setParamreturnType("String");
				pPhoneNumber.setParamValue(phoneNumber);
				
				ParamBO pUserId = new ParamBO();
				pUserId.setParamName("pUserId");
				pUserId.setParamType("SingleParamElement");
				pUserId.setParamreturnType("Integer");
				pUserId.setParamValue(userId);
				
				ParamBO pEmailId = new ParamBO();
				pEmailId.setParamName("pEmailId");
				pEmailId.setParamType("SingleParamElement");
				pEmailId.setParamreturnType("String");
				pEmailId.setParamValue(emailId);
				
				ParamBO pUserType = new ParamBO();
				pUserType.setParamName("pUserType");
				pUserType.setParamType("SingleParamElement");
				pUserType.setParamreturnType("String");
				pUserType.setParamValue(userType);
				
				ParamBO pLoggedInUserId = new ParamBO();
				pLoggedInUserId.setParamName("pLoggedInUserId");
				pLoggedInUserId.setParamType("SingleParamElement");
				pLoggedInUserId.setParamreturnType("String");
				pLoggedInUserId.setParamValue(loggedInUserId);
				
				
				ParamBO pNotAllowedToSearchList = new ParamBO();
				pNotAllowedToSearchList.setParamName("pNotAllowedToSearchList");
				pNotAllowedToSearchList.setParamType("List");
				pNotAllowedToSearchList.setParamreturnType("String");
				pNotAllowedToSearchList.setParamValue(notAllowedToSearchList);
				

				mymap.put("pStartDate", pStartDate);
				mymap.put("pEndDate", pEndDate);
				mymap.put("pUserName", pUserName);
				mymap.put("pPhoneNumber", pPhoneNumber);
				mymap.put("pUserId", pUserId);
				mymap.put("pEmailId", pEmailId);
				mymap.put("pUserType", pUserType);
				mymap.put("pLoggedInUserId", pLoggedInUserId);
				mymap.put("pNotAllowedToSearchList", pNotAllowedToSearchList);
				QueryMapperBO qmbo = SearchReport.getQuery(queryId, "ReportQuery", mymap);
				LOG.info("QueryMapperBO qmbo : GET_USERS_REPORT \n\n" + qmbo.getQuery());
				query = qmbo.getQuery();
				if (query != null) {
					rs = stmt.executeQuery(query);
				}
				List<UserBean> ub = new ArrayList<UserBean>();
				if (rs != null) {
					ub = ResultBeans.generateResultUserBean(rs);
				}
				return ub;
			}else if(queryId.equals("GET_ALL_ACCESS_RIGHTS_INFO")) {
				String query = null;
				Map<String, ParamBO> mymap = new HashMap<String,ParamBO>();
				Integer userId = (Integer) paramMap.get("userId");
				String userType = (String) paramMap.get("userType");
				
				ParamBO pUserId = new ParamBO();
				pUserId.setParamName("pUserId");
				pUserId.setParamType("SingleParamElement");
				pUserId.setParamreturnType("Integer");
				pUserId.setParamValue(userId);
				
				ParamBO pUserType = new ParamBO();
				pUserType.setParamName("pUserType");
				pUserType.setParamType("SingleParamElement");
				pUserType.setParamreturnType("String");
				pUserType.setParamValue(userType);

				mymap.put("pUserId", pUserId);
				mymap.put("pUserType", pUserType);
				QueryMapperBO qmbo = SearchReport.getQuery(queryId, "QueryMapper", mymap);
				LOG.info("QueryMapperBO qmbo : GET_ALL_ACCESS_RIGHTS_INFO \n\n" + qmbo.getQuery());
				query = qmbo.getQuery();
				if(query != null)
					rs = stmt.executeQuery(query);
				List<FunctionalityBO> qi = new ArrayList<FunctionalityBO>();
				if (rs != null) {
					qi = ResultBeans.generateResultForGetAllAccessRightsInfo(rs);
				}
				return qi;
			}else if(queryId.equals("GET_ADDED_QUESTIONS_FOR_SELECT_TEST")) {
				String query = null;
				Map<String, ParamBO> mymap = new HashMap<String,ParamBO>();
				Integer testID = (Integer) paramMap.get("testID");
				
				ParamBO pTestID = new ParamBO();
				pTestID.setParamName("pTestID");
				pTestID.setParamType("SingleParamElement");
				pTestID.setParamreturnType("Integer");
				pTestID.setParamValue(testID);

				mymap.put("pTestID", pTestID);
				QueryMapperBO qmbo = SearchReport.getQuery(queryId, "QueryMapper", mymap);
				LOG.info("QueryMapperBO qmbo : GET_ADDED_QUESTIONS_FOR_SELECT_TEST \n\n" + qmbo.getQuery());
				query = qmbo.getQuery();
				if(query != null)
					rs = stmt.executeQuery(query);
				List<QuestionBO> qi = new ArrayList<QuestionBO>();
				if (rs != null) {
					qi = ResultBeans.generateResultForGetAddedQuestionsForSelectedTest(rs);
				}
				return qi;
			}else if(queryId.equals("GET_USERS_ACCESS_GIVEN")) {
				String query = null;
				Map<String, ParamBO> mymap = new HashMap<String,ParamBO>();
				Integer userID = (Integer) paramMap.get("userID");
				
				ParamBO pUserID = new ParamBO();
				pUserID.setParamName("pUserID");
				pUserID.setParamType("SingleParamElement");
				pUserID.setParamreturnType("Integer");
				pUserID.setParamValue(userID);

				mymap.put("pUserID", pUserID);
				QueryMapperBO qmbo = SearchReport.getQuery(queryId, "QueryMapper", mymap);
				LOG.info("QueryMapperBO qmbo : GET_USERS_ACCESS_GIVEN \n\n" + qmbo.getQuery());
				query = qmbo.getQuery();
				if(query != null)
					rs = stmt.executeQuery(query);
				List<FunctionalityBO> qi = new ArrayList<FunctionalityBO>();
				if (rs != null) {
					qi = ResultBeans.generateResultForGetUsersAccessGiven(rs);
				}
				return qi;
			}else if(queryId.equals("GET_USERS_ACCESS_NOT_GIVEN")) {
				String query = null;
				Map<String, ParamBO> mymap = new HashMap<String,ParamBO>();
				Integer userID = (Integer) paramMap.get("userID");
				
				ParamBO pUserID = new ParamBO();
				pUserID.setParamName("pUserID");
				pUserID.setParamType("SingleParamElement");
				pUserID.setParamreturnType("Integer");
				pUserID.setParamValue(userID);

				mymap.put("pUserID", pUserID);
				QueryMapperBO qmbo = SearchReport.getQuery(queryId, "QueryMapper", mymap);
				LOG.info("QueryMapperBO qmbo : GET_USERS_ACCESS_NOT_GIVEN ::::--" + qmbo.getQuery());
				query = qmbo.getQuery();
				if(query != null)
					rs = stmt.executeQuery(query);
				List<FunctionalityBO> qi = new ArrayList<FunctionalityBO>();
				if (rs != null) {
					qi = ResultBeans.generateResultForGetUsersAccessNOTGiven(rs);
				}
				return qi;
			}else if(queryId.equals("GET_AND_VERIFY_USER")) {
				String query = null;
				Map<String, ParamBO> mymap = new HashMap<String,ParamBO>();
				String email = (String) paramMap.get("email");
				String phone = (String) paramMap.get("phone");
				
				ParamBO pEmailId = new ParamBO();
				pEmailId.setParamName("pEmailId");
				pEmailId.setParamType("SingleParamElement");
				pEmailId.setParamreturnType("String");
				pEmailId.setParamValue(email);
				
				ParamBO pPhoneNumber = new ParamBO();
				pPhoneNumber.setParamName("pPhoneNumber");
				pPhoneNumber.setParamType("SingleParamElement");
				pPhoneNumber.setParamreturnType("String");
				pPhoneNumber.setParamValue(phone);

				mymap.put("pEmailId", pEmailId);
				mymap.put("pPhoneNumber", pPhoneNumber);
				QueryMapperBO qmbo = SearchReport.getQuery(queryId, "QueryMapper", mymap);
				LOG.info("QueryMapperBO qmbo : GET_AND_VERIFY_USER :::--" + qmbo.getQuery());
				query = qmbo.getQuery();
				if(query != null)
					rs = stmt.executeQuery(query);
				List<UserBean> qi = new ArrayList<UserBean>();
				if (rs != null) {
					qi = ResultBeans.generateResultForGetUseForVerification(rs);
				}
				return qi;
			}else if(queryId.equals("GET_OTP_FOR_USER")) {
				String query = null;
				Map<String, ParamBO> mymap = new HashMap<String,ParamBO>();
				Integer userID = (Integer) paramMap.get("userID");
				
				ParamBO pUserId = new ParamBO();
				pUserId.setParamName("pUserId");
				pUserId.setParamType("SingleParamElement");
				pUserId.setParamreturnType("Integer");
				pUserId.setParamValue(userID);

				mymap.put("pUserId", pUserId);
				QueryMapperBO qmbo = SearchReport.getQuery(queryId, "QueryMapper", mymap);
				LOG.info("QueryMapperBO qmbo : GET_OTP_FOR_USER :::--" + qmbo.getQuery());
				query = qmbo.getQuery();
				if(query != null)
					rs = stmt.executeQuery(query);
				List<OTPBO> qi = new ArrayList<OTPBO>();
				if (rs != null) {
					qi = ResultBeans.generateResultForGetOTPForUser(rs);
				}
				return qi;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (con != null)
					con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
}
