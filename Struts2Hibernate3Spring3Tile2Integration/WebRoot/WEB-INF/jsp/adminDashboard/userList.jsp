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
<script
	src="./assets/js/core/jquery.min.js"></script>

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
/* .table>thead>tr>th, .table>tbody>tr>th, .table>tfoot>tr>th, .table>thead>tr>td, .table>tbody>tr>td, .table>tfoot>tr>td {
	padding: 0 !important;
	vertical-align: unset !important;
}
.table td, .table th {
	padding: 0 !important;
} */
.delete , .edit, .action-icon{
	padding: 0.5rem;
    cursor: pointer;
}
.table-responsive {
	overflow: auto !important;
}
.card-no-box-shadow {
	box-shadow: unset !important;
}
</style>
<script>
	$(document).ready(function() {
		getUsers();
		$('#userForm').on('submit', function(){
				var formInput=$(this).serialize();    
				$.getJSON('addUserByManagementUsers.action', formInput,function(data) {
					alert('User added successfully');
					getUsers();
				});  
				return false; 	
		});
		$('#userUpdateForm').on('submit', function(){
  			var formInput=$(this).serialize();    
			$.getJSON('updateProfile', formInput,function(data) {
				var str = '';
				if(data.successMessageList != null){
					for(var i in data.successMessageList){
						alert(data.successMessageList[i].successMsg);
					}
				}
				$('#updateModal').modal('hide');
				clearFormFields($('#userUpdateForm'));
				getUsers();
			});  
			return false; 
  		});
	});
	function clearFormFields(ths){
		$(ths).closest('form').find("input[type=text], input[type=password], input[type=email]").val("");
	}
	function getUsers() {
		$('#users-table-body').html('');
		$.ajax({
			type : "POST",
			url : "getUsers",
			success : function(itr) {
				var str = '';
				if (itr.userList != null && itr.userList.length > 0) {
					for (var i = 0; i < itr.userList.length; i++) {
						var userID = itr.userList[i].user_id;
						var name = itr.userList[i].name;
						var email = itr.userList[i].email_id;
						var phone = itr.userList[i].phone_number;
						var userType = itr.userList[i].user_type;
						var createdOn = itr.userList[i].created_on;
						var created_on = formatDate(new Date(itr.userList[i].created_on));
						//var btnClassforDisableEnable = 'btn-outline-warning';
						var btnClassforDisableEnable = 'text-warning';
						var disabledEnableOperationFunction = 'disableUser';
						var disabledEnableOperationText = '<i id="user-'+userID+'" class="fa fa-lock action-icon '+btnClassforDisableEnable+'" onclick="'+disabledEnableOperationFunction+'('+userID+',this);" aria-hidden="true"></i>';
						if(itr.userList[i].is_disabled == 1){
							//btnClassforDisableEnable = 'btn-outline-success';
							btnClassforDisableEnable = 'text-success';
							disabledEnableOperationFunction = 'enableUser';
							disabledEnableOperationText = '<i id="user-'+userID+'" class="fa fa-unlock action-icon '+btnClassforDisableEnable+'" onclick="'+disabledEnableOperationFunction+'('+userID+',this);" aria-hidden="true"></i>';
						}
						str += '<tr><th scope="row">' + userID + '</th><td>'
								+ name + '</td><td>' + email + '</td><td>'
								+ phone + '</td><td>' + userType + '</td><td>'
								+ created_on + '</td><td><i class="fa fa-trash text-danger delete" onclick="deleteThisUser('+userID+');"></i>'
								+disabledEnableOperationText
								+'<i class="fa fa-pencil action-icon" onclick="updateUser('+userID+',\''+email+'\');"></i></td></tr>';
					}
					$('#users-table-body').append(str);

				}else{
					str += '<div class="text-center"> No record found </div>';
					$('#users-table-body').append(str);
				}

			},
			error : function(itr) {
				alert("No values found..!!");
			}
		});
	}
	function deleteThisUser(userID){
		$('#deleteModal').modal('show');
		$('#deleteBtn').removeAttr('onclick');
		$('#deleteBtn').attr('onclick','deleteUser('+userID+');');
	}
	function deleteUser(userID){
		var data = {
				userId : userID
		};
		$.ajax({
			type : "POST",
			url : "deleteUser",
			data: JSON.stringify(data),
			dataType: 'json',
			contentType:"application/json;charset=utf-8",
			success : function(itr) {
				alert("User deleted");
				$('#deleteModal').modal('hide');
				getUsers();
			},
			error : function(itr) {
				alert("Error....!!");
			}
		});
	}
	
	function disableUser(userID,ths){
		var data = {
				userId : userID
		};
		var thisEle = ths; 
		$.ajax({
			type : "POST",
			url : "disableUser",
			data: JSON.stringify(data),
			dataType: 'json',
			contentType:"application/json;charset=utf-8",
			success : function(itr) {
				alert('User is disabled');
				getUsers();
			},
			error : function(itr) {
				alert("Error....!!");
			}
		});
	}
	function enableUser(userID, ths){
		var data = {
				userId : userID
		};
		var thisEle = ths; 
		$.ajax({
			type : "POST",
			url : "enableUser",
			data: JSON.stringify(data),
			dataType: 'json',
			contentType:"application/json;charset=utf-8",
			success : function(itr) {
				alert('User is enabled');
				getUsers();
			},
			error : function(itr) {
				alert("Error....!!");
			}
		});
	}
	function updateUser(userID,email){
		$('#userID').val(userID);
		$('#emailID').val(email);
		getUserProfile(userID,email);
		$('#updateModal').modal('show');
	}
	function getUserProfile(userID, emailId){
		var data = {
				userID : userID,
				emailId : emailId
		};
		 $.ajax({
	  			type : "POST",
	  			url : "getUserInfo",
	  			data: JSON.stringify(data),
				dataType: 'json',
				contentType:"application/json;charset=utf-8",
	  			success : function(res) {
	  				//$('#userName').val(res.map.email);
	  				$('#userName').val(res.map.name);
	  				$('#phoneNumber').val(res.map.phone);
	  			},
	  			error : function(res) {
	  				alert('Error while processing the request');
	  			}
	  		});
	}
	function callMyAction() {
		$.ajax({
			type : "POST",
			url : "getmydata",
			success : function(itr) {
				var x = "<ol>";
				$.each(itr.dataList, function() {
					x += "<li>" + this + "</li>";
				});
				x += "</ol>";
				$("#websparrow").html(x);
			},
			error : function(itr) {
				alert("No values found..!!");
			}
		});
	}
	function formatDate(date) {
		  var monthNames = [
		    "January", "February", "March",
		    "April", "May", "June", "July",
		    "August", "September", "October",
		    "November", "December"
		  ];

		  var day = date.getDate();
		  var monthIndex = date.getMonth();
		  var year = date.getFullYear();

		  return day + ' ' + monthNames[monthIndex] + ' ' + year;
		}
	function validateForm(){
		var re = /[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}/igm;
		var numbers = /^[-+]?[0-9]+$/;
		if($('#name').val() == '' || $('#name').val() == null){
			alert('Please enter name');
			return false;
		}else if($('#email').val() == '' || $('#email').val() == null){
			alert('Please enter an email');
			return false;
		}else if( $('#email').val() != null && !re.test($('#email').val())){
			alert('Please enter valid email address');
			return false;
		}else if($('#phone').val() == '' || $('#phone').val() == null){
			alert('Please enter phone');
			return false;
		}else if($('#phone').val() != null && $('#phone').val() != ''){
			if(! $('#phone').val().match(numbers)){
				alert('Please enter numbers only');
				return false;
			}else if($('#phone').val().length < 10 && $('#phone').val().length > 12 ){
				alert('Number should be between 10 and 12');
				return false;
			}			
		}else if($('#pwd').val() == '' || $('#pwd').val() == null ){
			alert('Please enter password');
			return false;
		}else if($('#cpwd').val() == '' || $('#cpwd').val() == null ){
			alert('Please confirm password');
			return false;
		}else if($('#pwd').val() != null && $('#pwd').val() != '' ){ 
			if($('#pwd').val() !=  $('#cpwd').val() ){
				alert('Password is not matched');
				return false;
			}
		}else if($('#pwd').val() != '' || $('#cpwd').val() != ''){
			if($('#pwd').val().length < 5 ||  $('#cpwd').val().length < 5 ){
				alert('Password must be of min 5 length');
				return false;
			}
		}
		return true;
		
	}
	function validateForm(){
		var re = /[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}/igm;
		var numbers = /^[-+]?[0-9]+$/;
		if($('#userName').val() == '' || $('#userName').val() == null){
			alert('Please enter name');
			return false;
		}else if($('#emailID').val() == '' || $('#emailID').val() == null){
			alert('Please enter an email');
			return false;
		}else if( $('#emailID').val() != null && !re.test($('#emailID').val())){
			alert('Please enter valid email address');
			return false;
		}else if($('#phoneNumber').val() == '' || $('#phoneNumber').val() == null){
			alert('Please enter phone');
			return false;
		}else if($('#phoneNumber').val() != null && $('#phoneNumber').val() != ''){
			if(! $('#phoneNumber').val().match(numbers)){
				alert('Please enter numbers only');
				return false;
			}else if($('#phoneNumber').val().length < 10 && $('#phoneNumber').val().length > 12 ){
				alert('Number should be between 10 and 12');
				return false;
			}			
		}else if($('#password').val() == '' || $('#password').val() == null ){
			alert('Please enter password');
			return false;
		}else if($('#cpassword').val() == '' || $('#cpassword').val() == null ){
			alert('Please confirm password');
			return false;
		}else if($('#password').val() != null && $('#password').val() != '' ){ 
			if($('#password').val() !=  $('#cpassword').val() ){
				alert('Password is not matched');
				return false;
			}
		}else if($('#password').val() != '' || $('#cpassword').val() != ''){
			if($('#password').val().length < 5 ||  $('#cpassword').val().length < 5 ){
				alert('Password must be of min 5 length');
				return false;
			}
		}
		return true;
		
	}
	
</script>
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
					<div class="col-md-12">
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
													<option>ADMIN</option>
													<option>CANDIDATE</option>
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
					<div class="col-md-12">
			           <div class="card">
			              <div class="card-header"></div>
			              <div class="card-body" id="users-card-body">
			              	<div class="table-responsive">
                  				<table class="table table-bordered"  style="border: 2px solid #000;">
                    				<thead class=" text-primary">
                      						<th>User ID</th>
											<th>Name</th>
											<th>Email</th>
											<th>Phone</th>
											<th>User Type</th>
											<th>Created On</th>
											<th>Action</th>
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
  <div class="modal fade" id="updateModal" role="dialog">
    <div class="modal-dialog" style="min-width: 900px;max-width: 900px;">
    
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
