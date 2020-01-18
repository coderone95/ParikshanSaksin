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
<link href="./assets/css/admin/groups.css" rel="stylesheet" />
<script src="./assets/js/admin/groups.js"></script>
<link href="./assets/css/loader.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.15/css/bootstrap-multiselect.css" type="text/css">
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.15/js/bootstrap-multiselect.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.min.css" rel="stylesheet" /> 
<link href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css" rel="stylesheet" />
</head>

<body class="">
	<input type="hidden" id="pageId" value="groups" />
	<input type="hidden" id="page" value="Groups" />
	<div class="wrapper ">
		<jsp:include page="adminSideBar.jsp"></jsp:include>
		<div class="main-panel">
			<jsp:include page="adminDashboardTopNav.jsp"></jsp:include>
			<div class="content">
				<div class="row">
					<s:if test="accessMap.get('M_ADD_GROUP')">
					<div class="col-md-12">
							<div class="row">
								<div class="col-md-6">
							         <div class="card demo-icons">
									<div class="card-header">
										<h4 id="user-form-card-heading">Create Group</h4>
									</div>
									<div class="card-body" id="">
										<form action="" method="post" id="createGroupForm">
												<div class="row">
													<div class="col-md-12 pr-1">
														<div class="row">
															<div class="col-md-8">
																<div class="form-group">
																	<!-- <label>Group Name</label>  -->
																	<input type="text" class="form-control" required name="groupbean.group_name" id="groupName"/>
																</div>
															</div>
														<div class="col-md-4">
															<div class="form-group">
																<input type="submit" style="margin: 0;" id="addGroupOrSet" class="btn btn-primary  btn-round" value="Add Group">
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
			           <div class="card">
			              <div class="card-header"></div>
			              <div class="card-body" id="group-card-body">
			              <div class="card-options text-right" style="margin-bottom: 0.2rem;"><i class="fa fa-filter filter-icon" data-toggle="modal" data-target="#groupFilterModal"></i></div>
			              	<div class="loaddercontainer groups-table-loader">
								<div class="lds-ring">
							        <div></div>
							        <div></div>
							        <div></div>
							        <div></div>
								</div>
							</div>
			              	<div class="table-responsive">
                  				<table class="table table-bordered table-vcenter table-hover table-stripped" style="border: 2px solid #000;" id="groupsTable">
                    				<thead class=" text-primary">
                      						<th class="text-nowrap" style='text-transform: initial;'>Group ID</th>
											<th class="text-nowrap" style='text-transform: initial;'>Group Name</th>
											<th class="text-nowrap" style='text-transform: initial;'>Created By</th>
											<th class="text-nowrap" style='text-transform: initial;'>Updated By</th>
											<th class="text-nowrap" style='text-transform: initial;'>Created On</th>
											<th class="text-nowrap" style='text-transform: initial;'>Updated On</th>
											<th class="text-nowrap group-table-action-th" style='text-transform: initial;'>Action</th>
                    				</thead>
			                    <tbody id="groups-table-body">
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
	<s:if test="accessMap.get('M_EDIT_GROUP')">	
	 <!-- Add Questions to Group Modal -->
  <div class="modal fade" id="addQuestionToGroupModal">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
       <div class="modal-header">
       		<h5 class="modal-title">Add Questions in Group</h5>
        	<button type="button" style="font-size: 2.5rem;" class="close" data-dismiss="modal">&times;</button>
      </div>
        <div class="modal-body">
				<div class="row">
					<div class="col-md-12">
			           <div class="card card-no-box-shadow">
			              <div class="card-header"></div>
			              <div class="card-body" id="questions-card-body">
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
  </div>
  </s:if>
  <!-- View Group Details Modal Popup -->
  <div class="modal fade" id="viewGroupDetailsModal">
    <div class="modal-dialog" style="max-height:90vh;">
      <!-- Modal content-->
      <div class="modal-content">
       <div class="modal-header">
       		<h5 class="modal-title">Group Details</h5>
        	<button type="button" style="font-size: 2.5rem;" class="close" data-dismiss="modal">&times;</button>
      </div>
        <div class="modal-body">
				<div class="row">
					<div class="col-md-12">
			           <div class="card card-no-box-shadow">
			              <div class="card-header"></div>
			              <div class="card-body" id="questions-card-body">
			              	<input type="hidden" id="groupID" />
			              	<input type="hidden" id="singleQuestionID" />
			              	<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label>Group Name</label> 
										<h5 class="form-control" id="group-name"></h5>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label>Number of Questions</label>
										<h5 class="form-control text-primary" id="total-que"></h5> 
									</div>
			              		</div>
							</div>
							<div class="row">
			              		<div class="col-md-12">
					              	<div class="table-responsive">
		                  				<table class="table">
		                    			<thead class=" text-primary">
		                      				<th>Question ID</th>
											<th>Question</th>
		                    			</thead>
					                    <tbody id="group-questions-table-body">
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
  <s:if test="accessMap.get('M_DELETE_GROUP')">
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
		        
<!-- 		        Modal footer -->
<!-- 		        <div class="modal-footer"> -->
<!-- 		          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button> -->
<!-- 		        </div> -->
		        
		      </div>
		    </div>
		  </div> 
	</s:if>
	<s:if test="accessMap.get('M_EDIT_GROUP')">
	<div class="modal fade" id="updateGroupModal">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
       <div class="modal-header">
       		<h5 class="modal-title">Update Group</h5>
        	<button type="button" style="font-size: 2.5rem;" class="close" data-dismiss="modal">&times;</button>
      </div>
        <div class="modal-body">
				<div class="row">
					<div class="col-md-12">
						<div class="card demo-icons card-no-box-shadow">
							<div class="card-header">
							</div>
							<div class="card-body">
								<input type="hidden" id="selectedGroupID">
								<div class="row">
									<div class="col-md-6 pr-1">
										<div class="form-group">
											<label>Group</label> 
											<input type="text" class="form-control" name="u-group-name" id="u-group-name" />
										</div>
									</div>
									<div class="col-md-6 pr-1">
										<div class="form-group">
											<label></label> 
											<button id="u-total-que" class="btn btn-primary btn-round">Add More Questions</button>
										</div>
									</div>
									<div class="col-md-6 pr-1"></div>
								</div>
								<div class="row">
				              		<div class="col-md-12">
						              	<div class="table-responsive">
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
								<div class="row">
										<div class="update ml-auto mr-auto">
											<input type="button" id="updateGroupBtn" class="btn btn-primary btn-round" onclick="updateGroupInfo();" value="Update Group">
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
  </s:if>
  <!-- Group Filter Modal -->
		  <div class="modal fade" id="groupFilterModal">
		    <div class="modal-dialog">
		      <div class="modal-content">
		      
		        <!-- Modal Header -->
		        <div class="modal-header">
		          <h5 class="modal-title">Group Filters</h5>
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
											<label>Group ID</label> 
											<input type="number" id="byGroupId" class="form-control">
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
											<label>Group Name</label> 
											<input type="text" id="byGroupName" class="form-control">
										</div>
									</div>
								</div>
								<div class="row">
										<div class="update ml-auto mr-auto">
											<input type="button" class="btn btn-primary btn-round" onclick="applyGroupsFilter('on_filter');" value="Apply Filters">
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
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/responsive/2.2.3/js/dataTables.responsive.min.js"></script>
	<script src="https://legacy.datatables.net/extras/thirdparty/ColReorderWithResize/ColReorderWithResize.js"></script>
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
