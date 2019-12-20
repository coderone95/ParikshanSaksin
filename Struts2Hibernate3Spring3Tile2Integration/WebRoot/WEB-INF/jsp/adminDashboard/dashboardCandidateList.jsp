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
<title>Admin Dashboard : Candidate List</title>
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
.table-responsive {
	overflow: auto !important;
}
.card-no-box-shadow {
	box-shadow: unset !important;
}
</style>
<script>
	$(document).ready(function() {
		// callMyAction();
		getUsers();
	});
	function getUsers() {
		$('#users-table-body').html('');
		$.ajax({
			type : "POST",
			url : "getCandidateUsers",
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
						var btnClassforDisableEnable = 'btn-warning';
						var disabledEnableOperationFunction = 'disableUser';
						var disabledEnableOperationText = 'Disable';
						var userSatus = 'Enabled';
						var textClass = 'text-success';
						if(itr.userList[i].is_disabled == 1){
							btnClassforDisableEnable = 'btn-success';
							disabledEnableOperationFunction = 'enableUser';
							disabledEnableOperationText = 'Enable';
							userSatus = 'Disabled';
							textClass = 'text-danger';
						}
						str += '<tr><th scope="row">' + userID + '</th><td>'
								+ name + '</td><td>' + email + '</td><td>'
								+ phone + '</td><td>'+userType+'</td><td class="'+textClass+'">'
								+ userSatus +'</td><td>' 
								+ created_on + '</td></tr>';

					}
					$('#users-table-body').append(str);

				}else{
					str += '<div class="text-center"> No record found </div>';
					$('.table').append(str);
				}

			},
			error : function(itr) {
				alert("No values found..!!");
			}
		});
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
</script>
</head>

<body class="">
	<input type="hidden" id="pageId" value="dash" />
	<input type="hidden" id="page" value="Candidates" />
	<div class="wrapper ">
		<jsp:include page="adminSideBar.jsp"></jsp:include>
		<div class="main-panel">
			<jsp:include page="adminDashboardTopNav.jsp"></jsp:include>
			<!-- <div class="panel-header panel-header-sm">

</div> -->
			<div class="content">
				<div class="row">
					<div class="col-md-12">
			           <div class="card">
			              <div class="card-header"><a href="adminDashboardPage.action"><i class="fa fa-arrow-left"></i> Back </a></div>
			              <div class="card-body" id="users-card-body">
			              	<div class="table-responsive">
                  				<table class="table table-bordered"  style="border: 2px solid #000;">
                    				<thead class=" text-primary">
                      						<th>User ID</th>
											<th>Name</th>
											<th>Email</th>
											<th>Phone</th>
											<th>User Type</th>
											<th>Status</th>
											<th>Created On</th>
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
