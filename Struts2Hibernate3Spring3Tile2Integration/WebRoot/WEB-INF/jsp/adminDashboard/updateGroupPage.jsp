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
<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
	
<!-- jQuery library -->
<script src="./assets/js/core/jquery.min.js"></script>
<!--     Fonts and icons     -->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
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
<link href="./assets/css/loader.css" rel="stylesheet" />
<script src="./assets/js/admin/updateGroupPage.js"></script>
<link href="./assets/css/admin/updateGroupPage.css" rel="stylesheet" />
<link href="./assets/plugins/jQuery-DataTables/css/jquery.dataTables.min.css" rel="stylesheet" />
</head>

<body class="">
	<input type="hidden" id="pageId" value="groups" />
	<input type="hidden" id="page" value="Groups" />
	<s:hidden id="selectedId" key="selectedGId" /> 
	<div class="wrapper ">
		<jsp:include page="adminSideBar.jsp"></jsp:include>
		<div class="main-panel">
			<jsp:include page="adminDashboardTopNav.jsp"></jsp:include>
			<div class="content">
				<div class="row">
					<div class="col-md-12">
						<div class="card demo-icons">
							<div class="loaddercontainer groups-update-loader-row-1" style="display:none;">
								<div class="lds-ring">
							        <div></div>
							        <div></div>
							        <div></div>
							        <div></div>
								</div>
							</div>
							<div class="card-header">
								<a href="groups"><i class="fa fa-arrow-left"></i> Back </a>
							</div>
							<div class="card-body">
								<input type="hidden" id="selectedGroupID">
								<div class="row">
									<div class="col-md-4 pr-1">
										<div class="form-group">
											<label>Group</label> 
											<input type="text" class="form-control" name="u-group-name" id="u-group-name" required />
										</div>
									</div>
									<div class="col-md-4 pr-1">
										<div class="form-group">
											<input type="button" style="margin: 24px 1px;" id="updateGroupBtn" class="btn btn-primary btn-round" onclick="updateGroupInfo();" value="Update Group">
										</div>
									</div>
									<div class="col-md-3 pr-1">
										<div class="form-group">
											<label>Questions Added</label> 
											<h5 class="form-control text-success" id="u-total-que"></h5>
										</div>
									</div>
								</div>
								<div class="row">
				              		<div class="col-md-12">
						              	<div class="table-responsive">
			                  				<table class="table table-bordered table-vcenter table-hover table-stripped" style="border: 2px solid #000;" id="qTable">
			                    			<thead class=" text-primary">
			                      				<th class="text-nowrap" style='text-transform: initial;'>Question ID</th>
												<th class="text-nowrap" style='text-transform: initial;'>Question</th>
												<th class="text-nowrap" style='text-transform: initial;'>Remove</th>
			                    			</thead>
						                    <tbody id="u-group-questions-table-body">
						                    </tbody>
						                  </table>
						                </div>
				              		</div>
								</div>
								</div>
							</div>
						</div>
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
			           </div>
			       </div>
			<jsp:include page="adminDashboardFooter.jsp" />
  
  	<!--Delete Modal -->
		  <div class="modal fade" id="deleteModal" role="dialog" style="z-index:99999999;">
		    <div class="modal-dialog">
		      <div class="modal-content">
		      
		        <!-- Modal Header -->
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        
		        <!-- Modal body -->
		        <div class="modal-body">
		          <p>Do you want to delete it?</p>
		          <div class="row">
		          		<div class="col-md-6">
		          			<button type="button" style="float:right;" class="btn btn-danger" id="deleteBtn">Yes</button>
		          		</div>
		          		<div class="col-md-6">
		          			<button type="button" class="btn btn-primary" data-dismiss="modal">No</button>
		          		</div>
		          </div>
		        </div>
		        
<!-- 		        Modal footer -->
<!-- 		        <div class="modal-footer"> -->
<!-- 		          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button> -->
<!-- 		        </div> -->
		        
		      </div>
		    </div>
		  </div> 
	
	<!--   Core JS Files   -->
	<script src="./assets/js/core/jquery.min.js"></script>
	<script src="./assets/js/core/popper.min.js"></script>
	<script src="./assets/js/core/bootstrap.min.js"></script>
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
