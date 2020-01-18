<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%-- <%@ taglib prefix="sx" uri="/struts-dojo-tags"%> --%>

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
<script src="./assets/js/common.js"></script>
<link href="./assets/css/dashboard-common.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.15/css/bootstrap-multiselect.css" type="text/css">
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.15/js/bootstrap-multiselect.min.js"></script>
<link href="./assets/css/loader.css" rel="stylesheet" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.min.css" rel="stylesheet" />
<link href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css" rel="stylesheet" />
<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<script src="https://legacy.datatables.net/extras/thirdparty/ColReorderWithResize/ColReorderWithResize.js"></script>
<script src="./assets/js/admin/testDetails.js"></script>

<style>
	#test-instructions {
		padding: 1rem;
	}
	.access-key-value{
		border:none;
	}
	.table-responsive{
		overflow:auto !important;
	}
</style>
</head>

<body class="">
	<input type="hidden" id="pageId" value="tests" />
	<input type="hidden" id="page" value="Test Details" />
	<s:hidden key="loginId" />
	<s:hidden key="testID" />

	<div class="wrapper ">
		<jsp:include page="adminSideBar.jsp"></jsp:include>
		<div class="main-panel">
			<jsp:include page="adminDashboardTopNav.jsp"></jsp:include>
			<div class="content">
				<div class="row">
					<div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
						<div class="card">
			              <div class="card-header">
								<div class="card-header"><a href="testsPage"><i class="fa fa-arrow-left"></i> Back </a></div>
							</div>
			              <div class="card-body">
			              	<div class="row">
								<div class="col-md-3 pr-1">
									<div class="form-group">
										<label>Test Name</label> 
										<p id="testName" class=""></p>
									</div>
								</div>
								<div class="col-md-3 pr-1">
									<div class="form-group">
										<label>Key</label> 
										<p id="testkey"class=""></p>
									</div>
								</div>
								<div class="col-md-3 pr-1">
									<div class="form-group">
										<label>Access Key</label> 
										<div id="accessKey" class=" input-group"></div>
									</div>
								</div>
								<div class="col-md-3">
									<div class="form-group">
										<label>No of Groups</label> 
										<p class="" id="total-added-groups"></p>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-3 pr-1">
									<div class="form-group">
										<label>Min Passing Criteria</label> 
										<p id="passingCriteria" class="">0</p>
									</div>
								</div>
								<div class="col-md-3 pr-1">
									<div class="form-group">
										<label>No of Questions</label> 
										<p class="" id="no-of-questions">0</p>
									</div>
								</div>
								<div class="col-md-3 pr-1">
									<div class="form-group">
										<label>Test Start On</label> 
										<p id="startOn"class=""></p>
									</div>
								</div>
								<div class="col-md-3 ">
									<div class="form-group">
										<label>Test Expires On</label> 
										<p id="endOn"class=""></p>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-3 pr-1">
									<div class="form-group">
										<label>Created By</label> 
										<p class="" id="createdBy"></p>
									</div>
								</div>
								<div class="col-md-3 pr-1">
									<div class="form-group">
										<label>Updated By</label> 
										<p class="" id="updatedBy"></p>
									</div>
								</div>
								<div class="col-md-3 pr-1">
									<div class="form-group">
										<label>Created On</label> 
										<p class="" id="createdOn"></p>
									</div>
								</div>
								<div class="col-md-3">
									<div class="form-group">
										<label>Updated On</label> 
										<p class="" id="updatedOn"></p>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-3 pr-1">
									<div class="form-group">
										<label>No of Candidates Attended</label> 
										<p class="">78</p>
									</div>
								</div>
								<div class="col-md-3 pr-1">
									<div class="form-group">
										<label>Test Duration</label> 
										<p class="" id="testTime"></p>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
										<label>Test Instructions</label> 
										<div id="test-instructions"  class="" style="max-height:500px; overflow:auto; border: 2px solid #000;">	
											<div class="loaddercontainer test-instructions-loder">
												<div class="lds-ring">
											        <div></div>
											        <div></div>
											        <div></div>
											        <div></div>
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
			</div>
		</div>
		<jsp:include page="adminDashboardFooter.jsp" />
	</div>
	<!-- Group List Modal -->
		  <div class="modal fade" id="groupListModal">
		    <div class="modal-dialog">
		      <div class="modal-content">
		      
		        <!-- Modal Header -->
		        <div class="modal-header">
		          <h5 class="modal-title">Groups</h5>
		           <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        <!-- Modal body -->
		        <div class="modal-body">
		        	<div class="row">
						<div class="col-md-12">
							<div class="table-responsive">
                  				<table class="table table-bordered table-vcenter table-hover table-stripped " id="groupListTable"  style="border: 2px solid #000;">
                    				<thead class=" text-primary">
                      						<th class="text-nowrap" style="text-transform: initial;">Group ID</th>
											<th class="text-nowrap" style="text-transform: initial;">Name</th>
                    				</thead>
			                    <tbody id="group-list-table-body">
			                    </tbody>
			                  </table>
			                </div>
						</div>
					</div>
		        </div>
		     </div>
		  </div>
		</div>
		
		<!-- Group List Modal -->
		  <div class="modal fade" id="questionListModal">
		    <div class="modal-dialog">
		      <div class="modal-content">
		      
		        <!-- Modal Header -->
		        <div class="modal-header">
		          <h5 class="modal-title">Questions</h5>
		           <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        <!-- Modal body -->
		        <div class="modal-body">
		        	<div class="row">
						<div class="col-md-12">
							<div class="table-responsive">
                  				<table class="table table-bordered table-vcenter table-hover table-stripped " id="questionListTable"  style="border: 2px solid #000;">
                    				<thead class=" text-primary">
                      						<th class="text-nowrap" style="text-transform: initial;">Question ID</th>
											<th class="text-nowrap" style="text-transform: initial;">Name</th>
                    				</thead>
			                    <tbody id="question-list-table-body">
			                    </tbody>
			                  </table>
			                </div>
						</div>
					</div>
		        </div>
		     </div>
		  </div>
		</div>
	<!-- show question details -->
  <div class="modal fade" id="showQuestionDetailsModal" >
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
       <div class="modal-header">
       		<b style="font-size:1.5rem;" class="modal-title">Question</b>
        	<button type="button" style="font-size: 2.5rem;" class="close" data-dismiss="modal">&times;</button>
      </div>
        <div class="modal-body">
				<div class="row">
					<div class="col-md-12">
						<div class="card demo-icons card-no-box-shadow">
							<div class="card-header">
								
							</div>
							<div class="card-body" id="question-options-card-body">
							<div class="row">
								<div class="col-md-12" id="questionArea">
									<h5 id="questionName"></h5>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12" id="optionsArea">
									<ol type="A"  id="optionList">
										
									</ol>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12" id="answerArea">
									<hr>
									<b id="answer"></b>
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
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
	
	<!-- Chart JS -->
	<script src="./assets/js/plugins/chartjs.min.js"></script>
	<!--  Notifications Plugin    -->
	<script src="./assets/js/plugins/bootstrap-notify.js"></script>
	<!-- Control Center for Now Ui Dashboard: parallax effects, scripts for the example pages etc -->
	<script src="./assets/js/paper-dashboard.min.js?v=2.0.0"
		type="text/javascript"></script>
</body>

</html>
