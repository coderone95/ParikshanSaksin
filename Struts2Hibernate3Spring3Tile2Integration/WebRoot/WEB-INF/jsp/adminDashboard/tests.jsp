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
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no" name="viewport" />
<!--     Fonts and icons     -->
<link href="./assets/fonts/montserrat.google.font.css" rel="stylesheet" />
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
<!-- CSS Files -->
<link href="./assets/css/bootstrap.min.css" rel="stylesheet" />
<link href="./assets/css/paper-dashboard.css?v=2.0.0" rel="stylesheet" />
<sx:head />
<script src="./assets/js/core/jquery.min.js"></script>
<script src="./assets/js/bootstrap-select.min.js"></script>
<script src="./assets/js/summernote.js"></script>
<link href="./assets/css/summernote.css" rel="stylesheet" />
<link href="./assets/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
<link href="./assets/plugins/bootstrap/glyphicon/bootstrap-glyphicons.css" rel="stylesheet" />
<script src="./assets/js/common.js"></script>
<link href="./assets/css/dashboard-common.css" rel="stylesheet" />
<link rel="stylesheet" href="./assets/plugins/bootstrap-multiselect/css/bootstrap-multiselect.css" type="text/css">
<script src="./assets/plugins/bootstrap-multiselect/js/bootstrap-multiselect.min.js"></script>
<link href="./assets/css/loader.css" rel="stylesheet" />
<script src="./assets/js/admin/tests.js"></script>
<link href="./assets/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css" rel="stylesheet" />
<link href="./assets/css/admin/tests.css" rel="stylesheet" />
<link href="./assets/plugins/jQuery-DataTables/css/jquery.dataTables.min.css" rel="stylesheet" />
<script src="./assets/plugins/jQuery-DataTables/js/jquery.dataTables.min.js"></script>
<script src="./assets/plugins/jQuery-DataTables/js/ColReorderWithResize.js"></script>
</head>

<body class="">
	<input type="hidden" id="pageId" value="tests" />
	<input type="hidden" id="page" value="Tests" />
	<s:hidden key="loginId" />

	<div class="wrapper ">
		<jsp:include page="adminSideBar.jsp"></jsp:include>
		<div class="main-panel">
			<jsp:include page="adminDashboardTopNav.jsp"></jsp:include>
			<div class="content">
				<div class="row">
					<s:if test="accessMap.get('M_ADD_TEST')">
					<div class="col-md-7 col-xs-12 col-sm-12 col-lg-7">
						<div class="card">
				              <div class="card-header"></div>
				              <div class="card-body">
						              <!-- <div class="loaddercontainer tests-create-loader">
										<div class="lds-ring">
									        <div></div>
									        <div></div>
									        <div></div>
									        <div></div>
										</div>
										</div> -->
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
								             <div class="stepwizard-step col-xs-3"> 
								                <a href="#step-9" type="button" class="btn btn-default btn-circle" disabled="disabled">9</a>
								                <p><small>Cargo</small></p>
								            </div>
								        </div>
								    </div>
								    <!-- <form role="form"> -->
								        <div class="panel panel-primary setup-content" id="step-1">
								            <div class="panel-heading">
								                 <h3 class="panel-title">Create Test</h3>
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
								                 <h3 class="panel-title">Create Test</h3>
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
								                 <h3 class="panel-title">Create Test</h3>
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
								                 <h3 class="panel-title">Create Test</h3>
								            </div>
								            <div class="panel-body">
								                <div class="form-group">
								                    <label class="control-label">Time</label>
								                    <input type="number" min="0" required="required" class="form-control" id="hrs" value="0" placeholder="Hours" /><br/>
								                    <input type="number" min="0" max="60" required="required" class="form-control" id="mins" value="0"  placeholder="Minutes" /><br/>
								                    <input type="number" min="0" max="60" required="required" class="form-control" id="secs" value="0" placeholder="Seconds" />
								                </div>
								                <button class="btn btn-primary nextBtn pull-right">Next</button>
								                <button class="btn btn-warning prevBtn pull-right">Prev</button>
								            </div>
								        </div>
								         <div class="panel panel-primary setup-content" id="step-5">
								            <div class="panel-heading">
								                 <h3 class="panel-title">Create Test</h3>
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
								                 <h3 class="panel-title">Create Test</h3>
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
								                 <h3 class="panel-title">Create Test</h3>
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
								                 <h3 class="panel-title">Create Test</h3>
								            </div>
								            <div class="panel-body">
								            	<s:select list="testMap" name="group-selected" id="availableGroups" multiple="true" />
												 <!-- <div class="table-responsive" style="max-height:300px;">
					                  				<table class="table">
					                    				<thead class=" text-primary">
					                    						<th><input type="checkbox" id="selectAll" /></th>
					                      						<th>Group ID</th>
																<th>Group Name</th>
					                    				</thead>
								                    <tbody id="groups-table-body">
								                    </tbody>
								                  </table>
								                </div> -->
								                <button class="btn btn-primary nextBtn pull-right">Next</button>
								                <button class="btn btn-warning prevBtn pull-right">Prev</button>
								            </div>
								        </div>
								        
								        <div class="panel panel-primary setup-content" id="step-9">
								            <div class="panel-heading">
								                 <h3 class="panel-title">Create Test</h3>
								            </div>
								            <div class="panel-body" id="last-step">
								                <div class="form-group">
								                    <label class="control-label">Test Instructions</label>
								                    <div id="summernote"></div>
								                </div>
								                <button class="btn btn-success pull-right" onclick="createTest();">Finish!</button>
								                <button class="btn btn-warning prevBtn pull-right">Prev</button>
								            </div>
								        </div>
								   <!--  </form> -->
						   		</div>
				           </div>
					</div>
					</s:if>
					<div class="col-md-12 col-log-12 col-xs-12 col-sm-12">
			           <div class="card">
			              <div class="card-header">
						  		<div class="card-options text-right" style="margin-bottom: 0.2rem;"><i class="fa fa-filter filter-icon" data-toggle="modal" data-target="#testFilterModal"></i></div>
						  </div>
			              <div class="card-body" id="tests-card-body">
			              	<div class="loaddercontainer tests-table-loader">
								<div class="lds-ring">
							        <div></div>
							        <div></div>
							        <div></div>
							        <div></div>
								</div>
							</div>
			              	<div class="table-responsive">
                  				<table class="table table-bordered table-vcenter table-hover table-stripped"  style="border: 2px solid #000;" id="dtable">
                    				<thead class=" text-primary">
                      						<th class="text-nowrap" style='text-transform: initial;'> ID </th>
											<th class="text-nowrap" style='text-transform: initial;'>Name</th>
											<th class="text-nowrap" style='text-transform: initial;'>Test Key</th>
											<th class="text-nowrap"style='text-transform: initial;'>Access Key</th>
											<!-- <th class="text-nowrap" style='text-transform: initial;'>Live</th> -->
											<th class="text-nowrap" style='text-transform: initial;'>Created On</th>
											<th class="text-nowrap" style='text-transform: initial;'>Updated On</th>
											<th class="text-nowrap" style='text-transform: initial;'>Created By</th>
											<th class="text-nowrap" style='text-transform: initial;'>Updated By</th>
											<th class="text-nowrap" style='text-transform: initial;'>Action</th>
                    				</thead>
			                    <tbody id="tests-table-body">
			                    
			                    </tbody>
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
	<s:if test="accessMap.get('M_DELETE_TEST')">
	<!--Delete Modal -->
		  <div class="modal fade" id="deleteModal" style="z-index:99999999;">
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
	</s:if>	  
	<!-- Tests Filter Modal -->
		  <div class="modal fade" id="testFilterModal" >
		    <div class="modal-dialog">
		      <div class="modal-content">
		      
		        <!-- Modal Header -->
		        <div class="modal-header">
		          <h5 class="modal-title">Test Filters</h5>
		           <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        <!-- Modal body -->
		        <div class="modal-body">
		          	<div class="row">
					<div class="col-md-12">
						<div class="card demo-icons card-no-box-shadow">
							<div class="card-body">
								<div class="row">
									<div class="col-md-6 pr-1">
										<div class="form-group">
											<label>From Date</label> 
											<input type="text" id="startDate" class="form-control datepicker">
										</div>
									</div>
									<div class="col-md-6 pr-1">
										<div class="form-group">
											<label>To Date</label> 
											<input type="text" id="endDate" class="form-control datepicker">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6 pr-1">
										<div class="form-group">
											<label>Test ID</label> 
											<input type="number" id="byTestId" class="form-control">
										</div>
									</div>
									<div class="col-md-6 pr-1">
										<div class="form-group">
											<label>Created By</label> 
											<input type="text" id="createdBy" class="form-control">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6 pr-1">
										<div class="form-group">
											<label>Test Name</label> 
											<input type="text" id="byTestName" class="form-control">
										</div>
									</div>
									<div class="col-md-6 pr-1">
										<div class="form-group">
											<label>Test Key</label> 
											<input type="text" id="byTestKey" class="form-control">
										</div>
									</div>
								</div>
								<div class="row">
										<div class="update ml-auto mr-auto">
											<input type="button" class="btn btn-primary btn-round" onclick="applyTestsFilter('on_filter');" value="Apply Filters">
											<input type="button" data-dismiss="modal" class="btn btn-primary btn-round close" value="Cancel">
										</div>
									</div>
								</div>
							</div>
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
	<script src="./assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>	
	<!--  Notifications Plugin    -->
	<script src="./assets/js/plugins/bootstrap-notify.js"></script>
	<script src="./assets/js/paper-dashboard.min.js?v=2.0.0" type="text/javascript"></script>
</body>

</html>
