<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8" />
<link rel="apple-touch-icon" sizes="76x76"
	href="./assets/img/apple-icon.png">
<link rel="icon" type="image/png" href="./assets/img/favicon.png">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>Admin Dashboard</title>
<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no'name='viewport'/>
<!-- jQuery library -->
<script src="./assets/js/core/jquery.min.js"></script>
<link href="./assets/fonts/montserrat.google.font.css" rel="stylesheet" />
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css"rel="stylesheet">
	
<!-- CSS Files -->
<link href="./assets/css/bootstrap.min.css" rel="stylesheet" />
<link href="./assets/css/paper-dashboard.css?v=2.0.0" rel="stylesheet" />
<link href="./assets/css/dashboard-common.css" rel="stylesheet" />
<link href="./assets/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css" rel="stylesheet" />
<link href="./assets/css/admin/userList.css" rel="stylesheet" />
<script src="./assets/js/admin/userList.js"></script>
<link href="./assets/css/loader.css" rel="stylesheet" />
<link href="./assets/plugins/jQuery-DataTables/css/jquery.dataTables.min.css" rel="stylesheet" />
</head>

<body class="">
	<input type="hidden" id="pageId" value="userList" />
	<input type="hidden" id="page" value="Users" />
	<div class="wrapper ">
		<jsp:include page="adminSideBar.jsp"></jsp:include>
		<div class="main-panel">
			<jsp:include page="adminDashboardTopNav.jsp"></jsp:include>
			<!-- <div class="panel-header panel-header-sm">

</div> -->
			<div class="content">
				<div class="row">
				<s:if test="accessMap.get('M_ADD_USER')">
					<div class="col-md-12 col-log-12 col-xs-12 col-sm-12">
						<div class="card demo-icons">
							<div class="card-header">
								<h4 id="user-form-card-heading">Add New User</h4>
								<div class="error-div" style="display: none;">
											<div class="err"
												style="padding: 0.5rem; border: 1px solid red;"></div>
								</div>
							</div>
							<div class="card-body" id="">
								<form action="" method="post" id="userForm">
									<div class="row">
										<div class="msg-div" style="display: none;color:#008000;margin: 0.5rem;">
											<div class="msg"
												style="padding: 0.1rem; border: 1px solid #008000;"></div>
										</div>
										
										<div class="col-md-4 pr-1">
											<div class="form-group">
												<label>Name</label> 
												<input type="text" class="form-control" id="name" name="userBean.name" placeholder="Enter Name *"  required/>
											</div>
										</div>
										<div class="col-md-4 pr-1">
											<div class="form-group">
												<label>Email Address</label> 
												<input type="email" class="form-control" id="email" name="userBean.email_id" placeholder="Enter Email address *" required/>
											</div>
										</div>
										<div class="col-md-4 pr-1">
											<div class="form-group">
												<label>Phone Number</label> 
												<input type="text" maxlength="10" minlength="10"  id="phone" name="userBean.phone_number" class="form-control" placeholder="Enter Phone *" required/>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-4 pr-1">
											<div class="form-group">
												<label>Password</label> 
												<input type="password" class="form-control" id="pwd" name="userBean.password" placeholder="Enter Password *" required/>
											</div>
										</div>
										<div class="col-md-4 pr-1">
											<div class="form-group">
												<label>Re-type Password</label> 
												<input type="password" class="form-control" id="cpwd" name="userBean.cpassword" placeholder="Confirm Password *" required/>
											</div>
										</div>
										<div class="col-md-4 pr-1">
											<div class="form-group">
												<label>User Type</label> 
												<select class="form-control" id="userType" name="userBean.user_type">
													<s:if test="accessMap.get('ADD_ADMIN_USER')"><option>ADMIN</option></s:if>
													<s:if test="accessMap.get('ADD_EXAMINER_USER')"><option>EXAMINER</option></s:if>
													<s:if test="accessMap.get('ADD_REVIEWER_USER')"><option>REVIEWER</option></s:if>
													<s:if test="accessMap.get('ADD_CANDIDATE_USER')"><option>CANDIDATE</option></s:if>
													<!-- <option>CANDIDATE</option> -->
<!-- 													<option>EXAMINER</option> -->
<!-- 													<option>REVIEWER</option> -->
												</select>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="update ml-auto mr-auto">
											<input type="submit" class="btn btn-primary btn-round" value="Add User">
										</div>
									</div>
								</form>

							</div>
						</div>
					</div>
					</s:if>
					<div class="col-md-12 col-log-12 col-xs-12 col-sm-12">
			           <div class="card">
			              <div class="card-header">
			              	<div class="card-options text-right" style="margin-bottom: 0.2rem;">
			              		<i class="fa fa-filter filter-icon mr-1" data-toggle="modal" data-target="#userFilterModal"></i>
			              		<a href="#" id="exportBtn"><i class="fa fa-file-excel-o filter-icon"></i></a>
			              	</div>
			              </div>
			              <div class="card-body" id="users-card-body">
			              	<div class="loaddercontainer users-table-loader">
								<div class="lds-ring">
							        <div></div>
							        <div></div>
							        <div></div>
							        <div></div>
								</div>
							</div>
			              	<div class="table-responsive">
                  				<table class="table table-bordered table-vcenter table-hover table-stripped " id="userListTable"  style="border: 2px solid #000;">
                    				<thead class=" text-primary">
                      						<th class="text-nowrap" style='text-transform: initial;'>User ID</th>
											<th class="text-nowrap" style='text-transform: initial;'>Name</th>
											<th class="text-nowrap" style='text-transform: initial;'>Email</th>
											<th class="text-nowrap" style='text-transform: initial;'>Phone</th>
											<th class="text-nowrap" style='text-transform: initial;'>User Type</th>
											<th class="text-nowrap" style='text-transform: initial;'>Created On</th>
											<th class="text-nowrap " style='text-transform: initial;'>Action</th>
                    				</thead>
			                    <tbody id="users-table-body">
			                    
			                    </tbody>
			                  </table>
			                </div>
			              </div>
			           </div>
			       </div>
				</div>
			</div>
			<jsp:include page="adminDashboardFooter.jsp" />
		</div>
	</div>
	
  <!-- Modal -->
  <div class="modal fade" id="updateModal">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
       <div class="modal-header">
       		<h5 class="modal-title">Update User</h5>
        	<button type="button" style="font-size: 2.5rem;" class="close" data-dismiss="modal">&times;</button>
      </div>
        <div class="modal-body">
				<div class="row">
					<div class="col-md-12">
						<div class="card demo-icons card-no-box-shadow">
							<div class="card-header">
<!-- 								<h4 id="user-form-card-heading">Update User</h4> -->
<!-- 								<div class="error-div" style="display: none;"> -->
<!-- 											<div class="err" -->
<!-- 												style="padding: 0.5rem; border: 1px solid red;"></div> -->
<!-- 								</div> -->
							</div>
							<div class="card-body" id="">
								<form action="" method="post" id="userUpdateForm">
									<div class="row">
										<div class="msg-div" style="display: none;color:#008000;margin: 0.5rem;">
											<div class="msg"
												style="padding: 0.1rem; border: 1px solid #008000;"></div>
										</div>
										<input type="hidden" name="userBean.user_id" id="userID">
										<div class="col-md-6 pr-1">
											<div class="form-group">
												<label>Name</label> 
												<input type="text" class="form-control" id="userName" name="userBean.name" placeholder="Enter Name *" />
											</div>
										</div>
										<div class="col-md-6 pr-1">
											<div class="form-group">
												<label>Email Address</label> 
												<input type="email" class="form-control" id="emailID" name="userBean.email_id" placeholder="Enter Email address *" disabled/>
											</div>
										</div>
										
									</div>
									<div class="row">
										<div class="col-md-6 pr-1">
											<div class="form-group">
												<label>Phone Number</label> 
												<input type="text"  id="phoneNumber" name="userBean.phone_number" class="form-control" placeholder="Enter Phone *" />
											</div>
										</div>
										<div class="col-md-6 pr-1">
											<div class="form-group">
												<label>Password</label> 
												<input type="password" class="form-control" id="password" name="userBean.password" placeholder="Enter Password *" />
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6 pr-1">
											<div class="form-group">
												<label>Re-type Password</label> 
												<input type="password" class="form-control" id="cpassword" name="userBean.cpassword" placeholder="Confirm Password *" />
											</div>
										</div>
									</div>
									<div class="row">
										<div class="update ml-auto mr-auto">
											<input type="submit" id="updateUserBtn" class="btn btn-primary btn-round" value="Update User">
										</div>
									</div>
								</form>
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
		        
<!-- 		        Modal footer -->
<!-- 		        <div class="modal-footer"> -->
<!-- 		          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button> -->
<!-- 		        </div> -->
		        
		      </div>
		    </div>
		  </div>  
	<!-- Users Filter Modal -->
		  <div class="modal fade" id="userFilterModal">
		    <div class="modal-dialog">
		      <div class="modal-content">
		      
		        <!-- Modal Header -->
		        <div class="modal-header">
		          <h5 class="modal-title">Users Filters</h5>
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
											<label>User ID</label> 
											<input type="number" id="byUserId" class="form-control">
										</div>
									</div>
									<div class="col-md-6 pr-1">
										<div class="form-group">
											<label>Email</label> 
											<input type="text" id="byEamil" class="form-control">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6 pr-1">
										<div class="form-group">
											<label>User Name</label> 
											<input type="text" id="byUserName" class="form-control">
										</div>
									</div>
									<div class="col-md-6 pr-1">
										<div class="form-group">
											<label>Phone</label> 
											<input type="text" id="byPhoneNumber" class="form-control">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6 pr-1">
										<div class="form-group">
											<label>User Type</label> 
											<select id="byUserType" class="form-control">
												<option value="" selected> --- None --- </option>
												<s:if test="accessMap.get('M_SHOW_ADMIN_USERS')"><option> ADMIN </option></s:if>
												<s:if test="accessMap.get('M_SHOW_EXAMINER_USERS')"><option> EXAMINER </option></s:if>
												<s:if test="accessMap.get('M_SHOW_REVIEWER_USERS')"><option> REVIEWER </option></s:if>
												<option> CANDIDATE </option>
											</select>
										</div>
									</div>
								</div>
								<div class="row">
										<div class="update ml-auto mr-auto">
											<input type="button" class="btn btn-primary btn-round" onclick="applyUsersFilter('on_filter');" value="Apply Filters">
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
	<script src="./assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
	<script src="./assets/plugins/jQuery-DataTables/js/jquery.dataTables.min.js"></script>
	<script src="./assets/plugins/jQuery-DataTables/js/ColReorderWithResize.js"></script>
	<script src="./assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
	<!--  Notifications Plugin    -->
	<script src="./assets/js/plugins/bootstrap-notify.js"></script>
	<script src="./assets/js/paper-dashboard.min.js?v=2.0.0" type="text/javascript"></script>
	<script>
	$('[data-toggle="tooltip"]').tooltip();
	</script>

</body>

</html>
