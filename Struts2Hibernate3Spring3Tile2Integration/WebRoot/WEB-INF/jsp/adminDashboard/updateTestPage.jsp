<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
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
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no"
	name="viewport" />

<!-- jQuery library -->
<%-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> --%>
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
<script src="./assets/js/summernote.js"></script>
<link href="./assets/css/summernote.css" rel="stylesheet" />
<link href="./assets/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet" />
<link href="./assets/css/dashboard-common.css" rel="stylesheet" />
<script src="./assets/js/common.js"></script>
<script src="./assets/js/admin/updateTest.js"></script>
<link href="./assets/css/admin/updateTest.css" rel="stylesheet" />
</head>

<body class="">
	<input type="hidden" id="pageId" value="tests" />
	<input type="hidden" id="page" value="Update Test" />
	<s:hidden key="loginId" />
	<s:hidden key="testID" />
	<div class="wrapper ">
		<jsp:include page="adminSideBar.jsp"></jsp:include>
		<div class="main-panel">
			<jsp:include page="adminDashboardTopNav.jsp"></jsp:include>
			<div class="content">
				<div class="row">
					<div class="col-md-7">
						<div class="card">
				              <div class="card-header"><a href="testsPage"><i class="fa fa-arrow-left"></i> Back </a></div>
				              <div class="card-body">
									 <div class="stepwizard">
								        <div class="stepwizard-row setup-panel" style="display:none">
								            <div class="stepwizard-step col-xs-3"> 
								                <a href="#step-1" type="button" class="btn btn-success btn-circle">1</a>
								                <p><small>Shipper</small></p>
								            </div>
								            <div class="stepwizard-step col-xs-3"> 
								                <a href="#step-2" type="button" class="btn btn-default btn-circle" disabled="disabled">2</a>
								                <p><small>Destination</small></p>
								            </div>
								            <div class="stepwizard-step col-xs-3"> 
								                <a href="#step-3" type="button" class="btn btn-default btn-circle" disabled="disabled">3</a>
								                <p><small>Schedule</small></p>
								            </div>
								            <div class="stepwizard-step col-xs-3"> 
								                <a href="#step-4" type="button" class="btn btn-default btn-circle" disabled="disabled">4</a>
								                <p><small>Cargo</small></p>
								            </div>
								            <div class="stepwizard-step col-xs-3"> 
								                <a href="#step-5" type="button" class="btn btn-default btn-circle" disabled="disabled">5</a>
								                <p><small>Cargo</small></p>
								            </div>
								            <div class="stepwizard-step col-xs-3"> 
								                <a href="#step-6" type="button" class="btn btn-default btn-circle" disabled="disabled">6</a>
								                <p><small>Cargo</small></p>
								            </div>
								             <div class="stepwizard-step col-xs-3"> 
								                <a href="#step-7" type="button" class="btn btn-default btn-circle" disabled="disabled">7</a>
								                <p><small>Cargo</small></p>
								            </div>
								            <div class="stepwizard-step col-xs-3"> 
								                <a href="#step-8" type="button" class="btn btn-default btn-circle" disabled="disabled">8</a>
								                <p><small>Cargo</small></p>
								            </div>
								        </div>
								    </div>
								    <!-- <form role="form"> -->
								        <div class="panel panel-primary setup-content" id="step-1">
								            <div class="panel-heading">
								                 <h3 class="panel-title">Update Test</h3>
								            </div>
								            <div class="panel-body">
								                <div class="form-group">
								                    <label class="control-label">Test Name</label>
								                    <input maxlength="100" type="text" required="required" class="form-control" id="testName" placeholder="Enter test name" />
								                </div>
								                <button class="btn btn-primary nextBtn pull-right">Next</button>
								            </div>
								        </div>
								        <div class="panel panel-primary setup-content" id="step-2">
								            <div class="panel-heading">
								                 <h3 class="panel-title">Update Test</h3>
								            </div>
								            <div class="panel-body">
								                <div class="form-group">
								                    <label class="control-label">Starts On</label>
								                    <input maxlength="100" type="text" required="required" class="form-control" id="startOn" placeholder="Exam starts on" />
								                </div>
								                <button class="btn btn-primary nextBtn pull-right">Next</button>
								                <button class="btn btn-warning prevBtn pull-right">Prev</button>
								            </div>
								        </div>
								        <div class="panel panel-primary setup-content" id="step-3">
								            <div class="panel-heading">
								                 <h3 class="panel-title">Update Test</h3>
								            </div>
								            <div class="panel-body">
								                <div class="form-group">
								                    <label class="control-label">Ends On</label>
								                    <input maxlength="100" type="text" required="required" class="form-control" id="endOn" placeholder="Exam ends on" />
								                </div>
								                <button class="btn btn-primary nextBtn pull-right">Next</button>
								                <button class="btn btn-warning prevBtn pull-right">Prev</button>
								            </div>
								        </div>
								        <div class="panel panel-primary setup-content" id="step-4">
								            <div class="panel-heading">
								                 <h3 class="panel-title">Update Test</h3>
								            </div>
								            <div class="panel-body">
								                <div class="form-group">
								                    <label class="control-label">Time</label>
								                    <input type="number" min="0" required="required" class="form-control"  value="0" id="hrs" placeholder="Hours" /><br/>
								                    <input type="number" min="0" max="60" required="required" class="form-control"  value="0" id="mins" placeholder="Minutes" /><br/>
								                    <input type="number" min="0" max="60" required="required" class="form-control"  value="0" id="secs" placeholder="Seconds" />
								                </div>
								                <button class="btn btn-primary nextBtn pull-right">Next</button>
								                <button class="btn btn-warning prevBtn pull-right">Prev</button>
								            </div>
								        </div>
								         <div class="panel panel-primary setup-content" id="step-5">
								            <div class="panel-heading">
								                 <h3 class="panel-title">Update Test</h3>
								            </div>
								            <div class="panel-body">
								                <div class="form-group">
								                    <label class="control-label">Test Key</label>
								                    <input maxlength="100" type="text" required="required" class="form-control" id="testkey" placeholder="Enter test key" />
								                </div>
								                <button class="btn btn-primary nextBtn pull-right">Next</button>
								                <button class="btn btn-warning prevBtn pull-right">Prev</button>
								            </div>
								        </div>
								        <div class="panel panel-primary setup-content" id="step-6">
								            <div class="panel-heading">
								                 <h3 class="panel-title">Update Test</h3>
								            </div>
								            <div class="panel-body">
								                <div class="form-group">
								                    <label class="control-label"></label>
								                    <button class="btn btn-primary" onclick="randomString();">Generate Access Key</button>
								                </div>
								                <div class="form-group">
								                	<label class="control-label">Access Key</label>
								                    <input maxlength="200" type="text" id="accessKey" class="form-control" />
								                </div>
								                <button class="btn btn-primary nextBtn pull-right">Next</button>
								                <button class="btn btn-warning prevBtn pull-right">Prev</button>
								            </div>
								        </div>
								        <div class="panel panel-primary setup-content" id="step-7">
								            <div class="panel-heading">
								                 <h3 class="panel-title">Update Test</h3>
								            </div>
								            <div class="panel-body">
								                <div class="form-group">
								                	<label class="control-label">Minimum Passing Criteria</label>
								                    <input type="number" id="passingCriteria" class="form-control" value="0"/>
								                </div>
								                <button class="btn btn-primary nextBtn pull-right">Next</button>
								                <button class="btn btn-warning prevBtn pull-right">Prev</button>
								            </div>
								        </div>
								        <div class="panel panel-primary setup-content" id="step-8">
								            <div class="panel-heading">
								                 <h3 class="panel-title">Update Test</h3>
								            </div>
								            <div class="panel-body" id="last-step">
								                <div class="form-group">
								                    <label class="control-label">Test Instructions</label>
								                    <div id="summernote"></div>
								                </div>
								                <button class="btn btn-success pull-right" onclick="updateTest();">Update Test!</button>
								                <button class="btn btn-warning prevBtn pull-right">Prev</button>
								            </div>
								        </div>
								   <!--  </form> -->
						   		</div>
				           </div>
					</div>
					<div class="col-md-5">
						<div class="card">
			              <div class="card-header">
						  </div>
			              <div class="card-body" >
			              		<div class="row">
			              			<div class="col-md-12">
			              				<h5 class="text-primary"> Total Added Groups</h5>
			              				<h5 id="total-added-groups">0</h5>
			              			</div>
			              			<div class="col-md-12">
			              				<h5 class="text-primary"> Available Groups</h5>
			              				<h5 id="total-available-groups">0</h5>
			              			</div>
			              		</div>
			              </div>
			           </div>
					</div>
					<div class="col-md-6">
			           <div class="card">
			              <div class="card-header"><h4>Added Groups</h4></div>
			              <div class="card-body">
						       <div class="table-responsive" style="max-height:500px;">
				                  	<table class="table" >
				                  		<thead class=" text-primary">
				                      		<th>Group ID</th>
											<th>Group</th>
											<th>Remove</th>
				                    	</thead>
							            <tbody id="added-group-table-body"></tbody>
							         </table>
						        </div>
						     </div>
						 </div>
					</div>
					<div class="col-md-6">
			           <div class="card">
			              <div class="card-header"><h4>Add Group to Test</h4></div>
			              <div class="card-body">
						      <div class="row">
						            <div class="col-md-8"></div>
							        <div class="col-md-4">
							        <div class="update ml-auto mr-auto">
										<input type="button" style="float:right;" class="btn btn-primary btn-round" onclick ="addSelectedGroupsToTest();" value="Add Selected Groups">
									</div>
								</div>
							</div>
						    <div class="table-responsive" style="max-height:500px;">
			                  	<table class="table">
			                    	<thead class=" text-primary">
			                    		<th><input type="checkbox" id="selectAll" /></th>
			                      		<th>Group ID</th>
										<th>Group</th>
			                    	</thead>
						            <tbody id="available-group-table-body"></tbody>
						        </table>
						     </div>
						     </div>
						 </div>
					</div>
				</div>
			</div>
		</div>
		
		<jsp:include page="adminDashboardFooter.jsp" />
	</div>
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
		      </div>
		    </div>
		  </div> 
	<!--   Core JS Files   -->
	<%-- <script src="./assets/js/core/jquery.min.js"></script> --%>
	<script src="./assets/js/core/popper.min.js"></script>
	<script src="./assets/js/core/bootstrap.min.js"></script>
	<script src="./assets/js/bootstrap-datetimepicker.js"></script>
	
	<!-- Chart JS -->
	<script src="./assets/js/plugins/chartjs.min.js"></script>
	<!--  Notifications Plugin    -->
	<script src="./assets/js/plugins/bootstrap-notify.js"></script>
	<!-- Control Center for Now Ui Dashboard: parallax effects, scripts for the example pages etc -->
	<script src="./assets/js/paper-dashboard.min.js?v=2.0.0"
		type="text/javascript"></script>
</body>

</html>
