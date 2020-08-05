<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<link rel="apple-touch-icon" sizes="76x76"
	href="./assets/img/apple-icon.png">
<link rel="icon" type="image/png" href="./assets/img/favicon.png">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>Admin Dashboard</title>
<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no'
	name='viewport' />
	
<!-- jQuery library -->
<script src="./assets/js/core/jquery.min.js"></script>
<link href="./assets/fonts/montserrat.google.font.css" rel="stylesheet" />
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">

<!-- CSS Files -->
<link href="./assets/css/bootstrap.min.css" rel="stylesheet" />
<link href="./assets/css/paper-dashboard.css?v=2.0.0" rel="stylesheet" />
<link href="./assets/css/summernote.css" rel="stylesheet" />
<sx:head />
<script src="./assets/js/core/jquery.min.js"></script>
<script src="./assets/js/bootstrap-select.min.js"></script>
<script src="./assets/js/common.js"></script>
<link href="./assets/css/dashboard-common.css" rel="stylesheet" />
<link href="./assets/css/admin/groups.css" rel="stylesheet" />
<script src="./assets/js/admin/createGroups.js"></script>
<link href="./assets/css/loader.css" rel="stylesheet" />
<link href="./assets/plugins/bootstrap-multiselect/css/bootstrap-multiselect.css" rel="stylesheet" />
<script type="text/javascript" src="./assets/plugins/bootstrap-multiselect/js/bootstrap-multiselect.min.js"></script>
<link href="./assets/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css" rel="stylesheet" />
<link href="./assets/plugins/jQuery-DataTables/css/jquery.dataTables.min.css" rel="stylesheet" />
</head>

<body class="">
	<input type="hidden" id="pageId" value="groups" />
	<input type="hidden" id="page" value="Groups" />
	<input type="hidden" id="groupId">
	<div class="wrapper ">
		<jsp:include page="adminSideBar.jsp"></jsp:include>
		<div class="main-panel">
			<jsp:include page="adminDashboardTopNav.jsp"></jsp:include>
			<div class="content">
				<div class="row">
					<s:if test="accessMap.get('M_ADD_GROUP')">
					<div class="col-md-12">
							<div class="row">
								<div class="col-md-12">
							         <div class="card demo-icons">
									<div class="card-header">
										<h4 id="user-form-card-heading">Create Group</h4>
									</div>
									<div class="card-body" id="">
										<form action="" method="post" id="createGroupForm">
												<div class="row">
													<div class="col-md-12 pr-1">
														<div class="row">
															<div class="col-md-4">
																<div class="form-group">
																	<!-- <label>Group Name</label>  -->
																	<input type="text" class="form-control" required name="groupbean.group_name" id="groupName"
																	 placeholder="Enter group name" />
																</div>
															</div>
														<div class="col-md-4 text-center">
															<div class="form-group">
																<input type="submit" style="margin: 0;" id="addGroupOrSet" class="btn btn-primary  btn-round" value="Add Group">
															</div>
														</div>
														<div class="col-md-3">
															<div class="form-group">
																<a class="btn btn-primary btn-round" style="margin: 0;" href="groups">Create One More Group</a>
															</div>
														</div>
													</div>
												</div>
											</div>
										</form>
									</div>
								</div>
							</div>
			       		</div>
			       	</div>
			       	</s:if>
			       	<div class="col-md-12">
			       		<s:if test="accessMap.get('M_ADD_QUESTION')">
						<div class="card demo-icons">
							<div class="card-header">
								<h4 id="user-form-card-heading">Add New Question</h4>
								<div class="error-div" style="display: none;">
											<div class="err"
												style="padding: 0.5rem; border: 1px solid red;"></div>
								</div>
							</div>
							<div class="card-body" id="">
									<div class="row">
										<div class="msg-div" style="display: none;color:#008000;margin: 0.5rem;">
											<div class="msg"
												style="padding: 0.1rem; border: 1px solid #008000;"></div>
										</div>
										
										<div class="col-md-8 pr-1">
											<div class="form-group">
												<label>Question</label> 
												<textarea class="form-control" required name="question" rows="4" id="question"></textarea>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-10 pr-1">
											<div class="form-group">
												<label>Answer Mode</label> 
												<select class="form-control" required name="answerMode" id="answerMode">
													<option value="radio">Radio</option>
													<option value="multi-select">Multi-Select</option>
												</select>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-10 pr-1">
											<div class="form-group" id="option-area">
											</div>
										</div>
										<div class="col-md-8 pr-1">
											<div class="form-group">
												<a href="#" onclick="addOption('option-area','y');">
													<i class="fa fa-plus-circle fa-lg"></i> Add option
												</a>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-8 pr-1">
											<div class="form-group">
												<label> Correct Answer</label>
												<select id="correctOption" class="form-control"></select>
											</div>											
										</div>
									</div>
									</div>
									<div class="row">
										<div class="update ml-auto mr-auto">
											<input type="button" id="addQueBtn" class="btn btn-primary btn-round" value="Add Question">
										</div>
									</div>
							</div>
							</s:if>
			       	</div>
				</div>
			</div>
		</div>
		<jsp:include page="adminDashboardFooter.jsp" />
	</div>
	<!--   Core JS Files   -->
	<script src="./assets/js/core/jquery.min.js"></script>
	<script src="./assets/js/core/popper.min.js"></script>
	<script src="./assets/js/core/bootstrap.min.js"></script>
	<script src="./assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
	<script src="./assets/plugins/jQuery-DataTables/js/jquery.dataTables.min.js"></script>
	<script src="./assets/plugins/jQuery-DataTables/js/dataTables.responsive.min.js"></script>
	<script src="./assets/plugins/jQuery-DataTables/js/ColReorderWithResize.js"></script>
	<script src="./assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
	<!--  Notifications Plugin    -->
	<script src="./assets/js/plugins/bootstrap-notify.js"></script>
	<!-- Control Center for Now Ui Dashboard: parallax effects, scripts for the example pages etc -->
	<script src="./assets/js/paper-dashboard.min.js?v=2.0.0"
		type="text/javascript"></script>
	<script src="./assets/js/summernote.js"></script>

</body>

</html>
