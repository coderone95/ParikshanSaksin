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
import com.codesvila.bean.GroupBO;
import com.codesvila.bean.GroupsTestInfoBO;
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

public class ApacheCommonsDBCP {

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
						System.out.println("Query :::" + query);
					}
				} else {
					// query = "select * from tbl_users order by 1 desc";
					mp = Mapper.getQuery(queryId);
					if (mp != null) {
						query = mp.getQuery();
						data = generic.nativeSQLQueryList(query);
					}
					System.out.println("Query :::" + query);
				}

				// rs = stmt.executeQuery(query);

				List<UserBean> ub = new ArrayList<UserBean>();
				if (data != null) {
					ub = ResultBeans.generateResultUserBean(data);
				}
				return ub;
			} else if (queryId.equals("GET_USER_PROFILE_DATA")) {
				StringBuilder email = new StringBuilder();
				if (listObj != null) {
					email = stringParams(listObj);
				}
				Map<String, ParamBO> myparamBO = new HashMap<String,ParamBO>();
				ParamBO pEmailId = new ParamBO();
				pEmailId.setParamName("pEmailId");
				pEmailId.setParamType("List");
				pEmailId.setParamreturnType("String");
				pEmailId.setParamValue(listObj);
				myparamBO.put("pEmailId", pEmailId);
				QueryMapperBO qmbo = SearchReport.getQuery("GET_USER_PROFILE_DATA","QueryMapper",myparamBO);
//				System.out.println("Query from qmbo \t\t\t:::::"+ qmbo.getQuery());
				System.out.println("emails " + email);
				//String query = "select * from tbl_users where email_id in (" + email.toString() + ") limit 1";
				//System.out.println("Query :::" + query);

				if (qmbo.getQuery() != null) {
					data = generic.nativeSQLQueryList(qmbo.getQuery());
				}
				List<UserBean> ub = new ArrayList<UserBean>();
				if (data != null) {
					ub = ResultBeans.generateResultUserBean(data);
				}
				return ub;
			} else if (queryId.equals("GET_MASTER_USER_DETAILS")) {
				StringBuilder userType = new StringBuilder();
				if (listObj != null) {
					userType = stringParams(listObj);
				}

				System.out.println("userType " + userType);
				String query = "select * from tbl_mst_user_type where user_type in (" + userType.toString()
						+ ") limit 1";
				System.out.println("userType Query :::" + query);
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
				String query = "select q.question_id as questionID, q.question as question , o.option_value as answer,"
						+ "q.created_by as createdBy, q.updated_by as updatedBy, q.created_on as createdOn, q.updated_on as updatedOn "
						+ " from tbl_questions q inner join tbl_que_options o on o.question_id = q.question_id where o.isCorrect = 1";

				System.out.println(" Returned Query :::\n\n\n\n" + query);
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
			} else if (queryId.equals("GET_OPTIONS_FOR_QUESTION")) {
				Integer questionId = null;
				String query = null;
				if (listObj != null && isParamsAvailable) {
					for (Object o : listObj) {
						questionId = (Integer) o;
						break;
					}
				}
				query = "select option_id, option_value from tbl_que_options where question_id = " + questionId + ";";
				System.out.println("query for : GET_OPTIONS_FOR_QUESTION " + query);
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

				query = "select q.question as question , o.option_value as answer from tbl_questions q inner join tbl_que_options o on\n"
						+ "q.question_id = o.question_id\n" + "where q.question_id =  " + questionId
						+ " and o.isCorrect = 1";
				System.out.println("query for : GET_QUESTION_WITH_ANSWER " + query);
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
				System.out.println("Query :::" + query);

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

				System.out.println("Query :::" + query);

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
				query = "select q.question_id, q.question from tbl_questions q "
						+"inner join tbl_questions_group qg on q.question_id = qg.question_id where qg.group_id in ("+ groupId.toString()+")";
				
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

				System.out.println("Query :::" + query);

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
				System.out.println("Query :::" + query);
				int i = stmt.executeUpdate(query);
				System.out.println("Deleting the test:::---"+i);
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
				query = "select q.question_id, q.question from tbl_questions_group qg inner join tbl_questions q "
						+ "on q.question_id = qg.question_id where qg.group_id in ("+ groupId.toString()+")";
				
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

				mymap.put("pStartDate", pStartDate);
				mymap.put("pEndDate", pEndDate);
				mymap.put("pCreatedBy", pCreatedBy);
				mymap.put("pQuestionName", pQuestionName);
				mymap.put("pQuestionId", pQuestionId);
				System.out.println("questionId \t\t\t\t \n" + questionId);
				QueryMapperBO qmbo = SearchReport.getQuery(queryId, "ReportQuery", mymap);
				System.out.println("QueryMapperBO qmbo : GET_QUESTIONS_REPORT \n\n" + qmbo.getQuery());
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
				System.out.println("questionId \t\t\t\t \n" + groupId);
				QueryMapperBO qmbo = SearchReport.getQuery(queryId, "ReportQuery", mymap);
				System.out.println("QueryMapperBO qmbo : GET_GROUPS_REPORT \n\n" + qmbo.getQuery());
				query = qmbo.getQuery();
				if(query != null)
					rs = stmt.executeQuery(query);
				List<GroupBO> gp = new ArrayList<GroupBO>();
				if(rs != null)
					gp = ResultBeans.generateResultForGroupBO(rs);
				return gp;
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

	public static Map getDataInMap(String queryId, List listObj, boolean isParamsAvailable) throws Exception {
		DataSource ds = DBCPDataSourceFactory.getDataSource();
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			stmt = con.createStatement();
			if (queryId.equals("GET_DASHBOARDS_CANDIDATE_COUNT")) {
				StringBuilder params = new StringBuilder();
				String query = null;
				query = "select count(user_id) as totalCandidateCount, 0 as totalAdminCount, 0 as totalQuestionsCount from tbl_users where user_type in('CANDIDATE')";
				System.out.println("Query :::" + query);
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
				System.out.println("Query :::" + query);
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
				System.out.println("Query :::" + query);
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
				System.out.println("Query :::" + query);
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
				System.out.println("Query :::" + query);
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
				System.out.println("Query :::" + query);
				List<TestBO> testInfo = new ArrayList<TestBO>();
				rs = stmt.executeQuery(query);
				if (rs != null) {
					testInfo = ResultBeans.generateResultForGetTestNameAndTime(rs); 
				}
				return testInfo;
			}else if(queryId.equals("GET_ALL_ATTENDED_TEST_DETAILS")) {
				String query = null;
//				query = "select id, test_id, org_id, user_id, test_started_time, test_ended_time,attempted,max_attempt from tbl_attended_test_details";
				query = "select atd.id, atd.test_id, atd.org_id, t.test_key, atd.user_id, atd.test_started_time, atd.test_ended_time,atd.attempted,atd.max_attempt "
						+ "from tbl_attended_test_details atd " + 
						"inner join tbl_tests t on t.test_id = atd.test_id ";
				System.out.println("Query :::" + query);
				List<AttendedTestDetailsBean> testInfo = new ArrayList<AttendedTestDetailsBean>();
				rs = stmt.executeQuery(query);
				if (rs != null) {
					testInfo = ResultBeans.generateResultForgetAllAttendedTestDetails(rs); 
				}
				return testInfo;
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
