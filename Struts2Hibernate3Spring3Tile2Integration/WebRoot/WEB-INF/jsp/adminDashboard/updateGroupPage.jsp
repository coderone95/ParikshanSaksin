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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!--     Fonts and icons     -->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
	
<!-- CSS Files -->
<link href="./assets/css/bootstrap.min.css" rel="stylesheet" />
<link href="./assets/css/paper-dashboard.css?v=2.0.0" rel="stylesheet" />
<!-- CSS Just for demo purpose, don't include it in your project -->
<link href="./assets/demo/demo.css" rel="stylesheet" />
 <sx:head />
<script src="./assets/js/core/jquery.min.js"></script>
<script src="./assets/js/bootstrap-select.min.js"></script>
<script src="./assets/js/common.js"></script>
<link href="./assets/css/dashboard-common.css" rel="stylesheet" />
<link href="./assets/css/loader.css" rel="stylesheet" />
<script src="./assets/js/admin/updateGroupPage.js"></script>
<link href="./assets/css/admin/updateGroupPage.css" rel="stylesheet" />
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
						              	<div class="table-responsive" style="min-height: 300px;max-height: 300px;">
			                  				<table class="table">
			                    			<thead class=" text-primary">
			                      				<th>Question ID</th>
												<th>Question</th>
												<th>Remove</th>
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
			           <div class="card">
			              <div class="card-header"></div>
			              <div class="card-body" id="questions-card-body">
			              				<div class="loaddercontainer groups-update-loader-row-2" style="display:none;">
											<div class="lds-ring">
										        <div></div>
										        <div></div>
										        <div></div>
										        <div></div>
											</div>
										</div>
						              	<input type="hidden" id="groupID" />
						              	<input type="hidden" id="singleQuestionID" />
						              	<div class="row">
						              		<div class="col-md-8"></div>
							              	<div class="col-md-4">
							              		<div class="update ml-auto mr-auto">
														<input type="button" style="float:right;" class="btn btn-primary btn-round" onclick ="addSelectedQuestionsToGroup();" value="Add Selected Questions">
												</div>
											</div>
										</div>
						              	<div class="table-responsive">
			                  				<table class="table">
			                    				<thead class=" text-primary">
			                    						<th><input type="checkbox" id="selectAll" /></th>
			                      						<th>Question ID</th>
														<th>Question</th>
			                    				</thead>
						                    <tbody id="questions-table-body">
						                    	
						                    </tbody>
						                  </table>
						                </div>
						              </div>
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
	<script src="./assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
	<!--  Google Maps Plugin    -->
	<script src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
	<!-- Chart JS -->
	<script src="./assets/js/plugins/chartjs.min.js"></script>
	<!--  Notifications Plugin    -->
	<script src="./assets/js/plugins/bootstrap-notify.js"></script>
	<!-- Control Center for Now Ui Dashboard: parallax effects, scripts for the example pages etc -->
	<script src="./assets/js/paper-dashboard.min.js?v=2.0.0"
		type="text/javascript"></script>
	<!-- Paper Dashboard DEMO methods, don't include it in your project! -->
	<script src="./assets/demo/demo.js"></script>
	

</body>

</html>
