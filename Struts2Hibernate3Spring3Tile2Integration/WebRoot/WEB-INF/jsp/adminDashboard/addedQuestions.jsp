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
<link href="./assets/css/dashboard-common.css" rel="stylesheet" />
<link href="./assets/css/loader.css" rel="stylesheet" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.min.css" rel="stylesheet" /> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<script src="./assets/js/core/jquery.min.js"></script>
<script src="./assets/js/bootstrap-select.min.js"></script>
<link href="./assets/css/admin/addedQuestions.css" rel="stylesheet" />
<script src="./assets/js/admin/addedQuestions.js"></script>
</head>
<body class="">
	<input type="hidden" id="pageId" value="tests" />
	<input type="hidden" id="page" value="Question List" />
	<s:hidden key="testID" />
	<div class="wrapper ">
		<jsp:include page="adminSideBar.jsp"></jsp:include>
		<div class="main-panel">
			<jsp:include page="adminDashboardTopNav.jsp"></jsp:include>
			<div class="content">
				<div class="row">
					<div class="col-md-7 col-lg-6 col-sm-12 col-xs-12">
						</div>
						<div class="col-md-12">
			           <div class="card">
			              <div class="card-header">
								<a class="back-btn"><i class="fa fa-arrow-left"></i> Back </a>
							</div>
							<div class="card-options text-right mr-1" style="margin-bottom: 0.2rem;">
								<i class="fa fa-file-pdf-o filter-icon" onclick="exportToPDF();"></i>
							</div>
			              <div class="card-body" id="questions-bank-card-body">
			              <div id="editor"></div>
			              	<div class="loaddercontainer questions-answer-bank-loader" style="display:none">
								<div class="lds-ring">
							        <div></div>
							        <div></div>
							        <div></div>
							        <div></div>
								</div>
							</div>
			              	<div class="question-ans-bank-area">
			                </div>
			              </div>
			           </div>
			       </div>
					</div>
				</div>
			</div>
			<jsp:include page="adminDashboardFooter.jsp" />
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
