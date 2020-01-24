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
<script src="./assets/js/core/jquery.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.min.css" rel="stylesheet" />
<link href="./assets/css/admin/userList.css" rel="stylesheet" />
<script src="./assets/js/admin/manageUsersAccess.js"></script>
<link href="./assets/css/loader.css" rel="stylesheet" />
<link href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css" rel="stylesheet" />
</head>

<body class="">
	<input type="hidden" id="pageId" value="userList" />
	<input type="hidden" id="page" value="Manage User's Access" />
	<s:hidden key="userID" />
	<s:hidden key="userType" />
	<div class="wrapper ">
		<jsp:include page="adminSideBar.jsp"></jsp:include>
		<div class="main-panel">
			<jsp:include page="adminDashboardTopNav.jsp"></jsp:include>
			<div class="content">
				<div class="row">
					<div class="col-md-12 col-log-12 col-xs-12 col-sm-12">
						<div class="card">
				              <div class="card-header">
									<div class="card-options text-left" style="margin-bottom: 0.2rem;">
										<a href="adminUserListePage"><i class="fa fa-arrow-left"></i> Back </a><br><br>
										<h5>Grant Access </h5>
									</div>
									<div class="card-options text-right" style="margin-bottom: 0.2rem;">
				              			<button class="btn btn-primary" id="give-selected-access">Grant Selected Access</button>
				              		</div>
								</div>
				              <div class="card-body">
								<div class="row access-not-given-area">
				              	</div>				              	
				              </div>
				         </div>
			         </div>
				</div>
				<div class="row">
					
					<div class="col-md-12 col-log-12 col-xs-12 col-sm-12">
			           <div class="card">
			              <div class="card-header">
			              	<div class="card-options text-left" style="margin-bottom: 0.2rem;">
			              		<h5>Access Granted <i class="fa fa-check-circle ml-1" style="font-size:20px;color:#198764;"></i></h5>
			              	</div>
			              </div>
			              <div class="card-body">
			              	<div class="row access-given-area">
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
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
	
<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<script src="https://legacy.datatables.net/extras/thirdparty/ColReorderWithResize/ColReorderWithResize.js"></script>
<%-- <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script> --%>
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
	<script>
	$('[data-toggle="tooltip"]').tooltip();
	</script>

</body>

</html>
