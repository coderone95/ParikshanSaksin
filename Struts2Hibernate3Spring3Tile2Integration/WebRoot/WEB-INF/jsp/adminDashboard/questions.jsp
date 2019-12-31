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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!--     Fonts and icons     -->
<link
	href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200"
	rel="stylesheet" />
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css"
	rel="stylesheet">
	
<!-- CSS Files -->
<link href="./assets/css/bootstrap.min.css" rel="stylesheet" />
<link href="./assets/css/paper-dashboard.css?v=2.0.0" rel="stylesheet" />
<!-- CSS Just for demo purpose, don't include it in your project -->
<link href="./assets/demo/demo.css" rel="stylesheet" />
<link href="./assets/css/dashboard-common.css" rel="stylesheet" />
<link href="./assets/css/loader.css" rel="stylesheet" />
<!-- <link href="./assets/css/bootstrap-datetimepicker.min.css" rel="stylesheet" /> -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.min.css" rel="stylesheet" /> 

 <sx:head />
<script
	src="./assets/js/core/jquery.min.js"></script>
<script
	src="./assets/js/bootstrap-select.min.js"></script>
	<style>
	.padding-0-6-rem{
		padding: 0.6rem;
	}
	</style>

<script src="./assets/js/admin/questions.js"></script>
<%-- <script src="./assets/js/admin/questions.min.js"></script> --%>
<style type="text/css">
.errorDiv {
	color: red;
}
.error-msg {
	color:red
}
.success-msg{
	color: #008000;
}
.error-msg b{
	margin-bottom: 1rem;
    padding: 0.1rem;
    border: 1px solid red;
}
.success-msg b{
	margin-bottom: 1rem;
    padding: 0.1rem;
    border: 1px solid #008000;
}
.padding-0-6-rem{
	padding: 0.6rem;
}
.custom-switch{
	cursor:pointer;
	float:right;
	font-size: 2rem;
}
.fa-toggle-on, .fa-toggle-off{
	color:#51cbce;
}
#updateOptions li{
	 list-style: none;
}
.filter-icon {
border-radius: 5px;
    cursor: pointer;
    padding: 0.5rem;
    font-size: 23px;
    background: #0b1961;
    color: #fff;
}
.table-responsive {
    overflow: auto !important;
}
.card-no-box-shadow {
	box-shadow: unset;
}
.delete , .edit{
	padding: 0.5rem;
    cursor: pointer;
}
.datepicker.datepicker-dropdown.dropdown-menu.datepicker-orient-left.datepicker-orient-bottom {
    box-shadow: 0 .5rem 1rem rgba(0,0,0,.15)!important;
    font-size: unset;
    padding: 1rem;
}
</style>

</head>

<body class="">
	<input type="hidden" id="pageId" value="questions" />
	<input type="hidden" id="page" value="Questions" />
		
	<div class="wrapper ">
		<jsp:include page="adminSideBar.jsp"></jsp:include>
		<div class="main-panel">
			<jsp:include page="adminDashboardTopNav.jsp"></jsp:include>
			<!-- <div class="panel-header panel-header-sm">

</div> -->
			<div class="content">
				<div class="row">
					<div class="col-md-7 col-lg-6 col-sm-12 col-xs-12">
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
						</div>
						<div class="col-md-12">
			           <div class="card">
			              <div class="card-header"></div>
			              <div class="card-body" id="questions-card-body">
			              	<div class="loaddercontainer questions-table-loader">
								<div class="lds-ring">
							        <div></div>
							        <div></div>
							        <div></div>
							        <div></div>
								</div>
							</div>
			              	<div class="card-options text-right" style="margin-bottom: 0.2rem;"><i class="fa fa-filter filter-icon" data-toggle="modal" data-target="#questionFilterModal"></i></div>
			              	<div class="table-responsive">
                  				<table class="table table-bordered"  style="border: 2px solid #000;">
                    				<thead class=" text-primary">
                      						<th>Question ID</th>
											<th>Question</th>
											<!-- <th>Answer</th> -->
											<th>Created By</th>
											<th>Updated By</th>
											<th>Action</th>
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
			<jsp:include page="adminDashboardFooter.jsp" />
		</div>
	
	<div class="modal fade" id="showQuestionDetailsModal" role="dialog">
    <div class="modal-dialog" style="min-width: 900px;max-width: 900px;">
    
      <!-- Modal content-->
      <div class="modal-content">
       <div class="modal-header">
       		<b style="font-size:1.5rem;" class="modal-title">Question</b>
        	<button type="button" style="font-size: 2.5rem;" class="close" data-dismiss="modal">&times;</button>
      </div>
        <div class="modal-body">
				<div class="row">
					<div class="col-md-12">
						<div class="card demo-icons card-no-box-shadow ">
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
	
	<div class="modal fade" id="updateQuestionModal" role="dialog">
    <div class="modal-dialog" >
    
      <!-- Modal content-->
      <div class="modal-content">
       <div class="modal-header">
       		<h5 class="modal-title">Update Question</h5>
        	<button type="button" style="font-size: 2.5rem;" class="close" data-dismiss="modal">&times;</button>
      </div>
        <div class="modal-body">
				<div class="row">
					<div class="col-md-12 ">
						<div class="card card-no-box-shadow  demo-icons">
							<div class="loaddercontainer questions-edit-loader" style="display:none;">
								<div class="lds-ring">
							        <div></div>
							        <div></div>
							        <div></div>
							        <div></div>
								</div>
							</div>
							<div class="card-header">
								<div class="card-options">
									<i class="fa fa-toggle-off custom-switch"></i>
								</div>
							</div>
							<div class="card-body">
								<div class="row">
									<div class="col-md-12 pr-1">
										<div class="form-group">
											<label>Question</label> 
											<textarea class="form-control update-question-field" name="question" id="updateQuestion_name" disabled></textarea>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12 pr-1">
										<div class="form-group" id="">
											<div id="updateOptions">
												
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12 pr-1">
										<div class="form-group" id="updateAnswer_name">
											<label>Select Answer</label> 
											<select id="updateCorrectOption" class="form-control update-question-field" disabled="true"></select>
										</div>
									</div>
								</div>
								<div class="row">
										<div class="update ml-auto mr-auto">
											<input type="button" id="updateQueBtn" class="btn btn-primary btn-round" onclick="updateQue();" value="Update Question">
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
<!--Delete Modal -->
		  <div class="modal" id="deleteModal">
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
	<!-- Question Filter Modal -->
		  <div class="modal fade" id="questionFilterModal" role="dialog">
		    <div class="modal-dialog">
		      <div class="modal-content">
		      
		        <!-- Modal Header -->
		        <div class="modal-header">
		          <h5 class="modal-title">Question Filters</h5>
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
											<label>Question ID</label> 
											<input type="number" id="byQuestionId" class="form-control">
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
											<label>Question Name</label> 
											<input type="text" id="byQuestionName" class="form-control">
										</div>
									</div>
								</div>
								<div class="row">
										<div class="update ml-auto mr-auto">
											<input type="button" class="btn btn-primary btn-round" onclick="applyQuestionsFilter('on_filter');" value="Apply Filters">
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
	<script src="./assets/js/core/jquery.min.js"></script>
	<script src="./assets/js/core/popper.min.js"></script>
	<script src="./assets/js/core/bootstrap.min.js"></script>
	<%-- <script src="./assets/js/bootstrap-datetimepicker.js"></script> --%>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
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
