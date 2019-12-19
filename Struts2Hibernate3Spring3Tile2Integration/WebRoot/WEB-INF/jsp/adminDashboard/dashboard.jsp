<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <link rel="apple-touch-icon" sizes="76x76" href="./assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="./assets/img/favicon.png">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <title>
    Admin Dashboard
  </title>
  <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
  <!--     Fonts and icons     -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
  <!-- CSS Files -->
  <link href="./assets/css/bootstrap.min.css" rel="stylesheet" />
  <link href="./assets/css/paper-dashboard.css?v=2.0.0" rel="stylesheet" />
  <!-- CSS Just for demo purpose, don't include it in your project -->
  <link href="./assets/demo/demo.css" rel="stylesheet" />
  <link href="./assets/css/dashboard-common.css" rel="stylesheet" />
  <style>
  	@media screen and (min-width: 768px) {
        .modal-dialog {
          width: 900px; /* New width for default modal */
        }
        .modal-sm {
          width: 550px; /* New width for small modal */
        }
    }
    @media screen and (min-width: 992px) {
        .modal-lg {
          width: 1000px; /* New width for large modal */
        }
    }
    .padding-0-6-rem{
	padding: 0.5rem;
}
  </style>
  <script>
  	$(document).ready(function(){
  		sessionStorage.setItem("loginId",($('#login_id').val()));
  		populateCandidateCount();
  		populateAdminUsersCount();
  		populateQuestionsCount();
  	});
  	function populateCandidateCount(){
  		$('#candidateCount').html('');
		$.ajax({
			type : "POST",
			url : "populateCandidateCount",
			dataType: 'json',
			contentType:"application/json;charset=utf-8",
			success : function(data) {
				$('#candidateCount').append('<a href="candidateUserList.action">'+data.countMap.totalCandidateCount+'</a>')
			},
			error : function(data) {
				alert("Error....!!");
			}
		});
  	}
  	function populateAdminUsersCount(){
  		$('#AdminCount').html('');
		$.ajax({
			type : "POST",
			url : "populateAdminUsersCount",
			dataType: 'json',
			contentType:"application/json;charset=utf-8",
			success : function(data) {
				$('#AdminCount').append('<a href="#">'+data.adminCountMap.totalAdminCount+'</a>')
			},
			error : function(data) {
				alert("Error....!!");
			}
		});
  	}
  	function populateQuestionsCount(){
  		$('#AdminCount').html('');
		$.ajax({
			type : "POST",
			url : "populateQuestionsCount",
			dataType: 'json',
			contentType:"application/json;charset=utf-8",
			success : function(data) {
				$('#questionsCount').append('<a href="#">'+data.questionsCountMap.totalQuestionsCount+'</a>')
			},
			error : function(data) {
				alert("Error....!!");
			}
		});
  	}
  </script>
</head>

<body class="">
	<s:hidden key="login_id" />
	<input type="hidden" id="pageId" value="dash" />
	<input type="hidden" id="page" value="Dashboard" />
  <div class="wrapper ">
  	<jsp:include page="adminSideBar.jsp"></jsp:include>
    <div class="main-panel">
		<jsp:include page="adminDashboardTopNav.jsp"></jsp:include>
      <!-- <div class="panel-header panel-header-lg">

  <canvas id="bigDashboardChart"></canvas>


</div> -->
      <div class="content">
        <div class="row">
          <div class="col-lg-4 col-md-6 col-sm-6">
            <div class="card card-stats">
              <div class="card-body ">
                <div class="row">
                  <div class="col-5 col-md-4">
                    <div class="icon-big text-center icon-warning">
                      <i class="fa fa-users  text-danger"></i>
                    </div>
                  </div>
                  <div class="col-7 col-md-8">
                    <div class="numbers">
                      <p class="card-category">Candidates</p>
                      <p class="card-title" id="candidateCount"></p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-lg-4 col-md-6 col-sm-6">
            <div class="card card-stats">
              <div class="card-body ">
                <div class="row">
                  <div class="col-5 col-md-4">
                    <div class="icon-big text-center icon-warning">
                      <i class="fa fa-users text-success"></i>
                    </div>
                  </div>
                  <div class="col-7 col-md-8">
                    <div class="numbers">
                      <p class="card-category">Admin</p>
                      <p class="card-title" id="AdminCount"></p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-lg-4 col-md-6 col-sm-6">
            <div class="card card-stats">
              <div class="card-body ">
                <div class="row">
                  <div class="col-5 col-md-4">
                    <div class="icon-big text-center icon-warning">
                      <i class=" fa fa-question-circle-o text-default"></i>
                    </div>
                  </div>
                  <div class="col-7 col-md-8">
                    <div class="numbers">
                      <p class="card-category">Questions</p>
                      <p class="card-title" id="questionsCount"><p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          
          <!-- <div class="col-lg-3 col-md-6 col-sm-6">
            <div class="card card-stats">
              <div class="card-body ">
                <div class="row">
                  <div class="col-5 col-md-4">
                    <div class="icon-big text-center icon-warning">
                      <i class="nc-icon nc-favourite-28 text-primary"></i>
                    </div>
                  </div>
                  <div class="col-7 col-md-8">
                    <div class="numbers">
                      <p class="card-category">Capacity</p>
                      <p class="card-title">150GB
                        <p>
                    </div>
                  </div>
                </div>
              </div>
              <div class="card-footer ">
                <hr>
                <div class="stats">
                  <i class="fa fa-refresh"></i> Update now
                </div>
              </div>
            </div>
          </div> -->
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="card ">
              <div class="card-header ">
                <h5 class="card-title">Users Behavior</h5>
                <p class="card-category">24 Hours performance</p>
              </div>
              <div class="card-body ">
                <canvas id=chartHours width="400" height="100"></canvas>
              </div>
              <div class="card-footer ">
                <hr>
                <div class="stats">
                  <i class="fa fa-history"></i> Updated 3 minutes ago
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-4">
            <div class="card ">
              <div class="card-header ">
                <h5 class="card-title">Email Statistics</h5>
                <p class="card-category">Last Campaign Performance</p>
              </div>
              <div class="card-body ">
                <canvas id="chartEmail"></canvas>
              </div>
              <div class="card-footer ">
                <div class="legend">
                  <i class="fa fa-circle text-primary"></i> Opened
                  <i class="fa fa-circle text-warning"></i> Read
                  <i class="fa fa-circle text-danger"></i> Deleted
                  <i class="fa fa-circle text-gray"></i> Unopened
                </div>
                <hr>
                <div class="stats">
                  <i class="fa fa-calendar"></i> Number of emails sent
                </div>
              </div>
            </div>
          </div>
          <div class="col-md-8">
            <div class="card card-chart">
              <div class="card-header">
                <h5 class="card-title">NASDAQ: AAPL</h5>
                <p class="card-category">Line Chart with Points</p>
              </div>
              <div class="card-body">
                <canvas id="speedChart" width="400" height="100"></canvas>
              </div>
              <div class="card-footer">
                <div class="chart-legend">
                  <i class="fa fa-circle text-info"></i> Tesla Model S
                  <i class="fa fa-circle text-warning"></i> BMW 5 Series
                </div>
                <hr/>
                <div class="card-stats">
                  <i class="fa fa-check"></i> Data information certified
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
	<jsp:include page="adminDashboardFooter.jsp" />
	<!--  Candidate Users List Modal Popup -->
	<div class="modal fade users-list-modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="display:none;">
  <div class="modal-dialog modal-lg modal-sm">
    <div class="modal-content">
      
    	
        	<div class="row">
      		<div class="col-md-12">
						<div class="card">
							<div class="card-header"></div>
							<div class="card-body" id="users-card-body">
								<table class="table">
									<thead class="thead-dark">
										<tr>
											<th scope="col" class="text-center">User ID</th>
											<th scope="col" class="text-center">Name</th>
											<th scope="col" class="text-center">Email</th>
											<th scope="col" class="text-center">Phone</th>
											<th scope="col" class="text-center">User Type</th>
											<th scope="col" class="text-center">Created On</th>
										</tr>
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
  <script src="./assets/js/paper-dashboard.min.js?v=2.0.0" type="text/javascript"></script>
  <!-- Paper Dashboard DEMO methods, don't include it in your project! -->
  <script src="./assets/demo/demo.js"></script>
  <script>
    $(document).ready(function() {
      // Javascript method's body can be found in assets/assets-for-demo/js/demo.js
      demo.initChartsPages();
    });
  </script>
</body>

</html>
    