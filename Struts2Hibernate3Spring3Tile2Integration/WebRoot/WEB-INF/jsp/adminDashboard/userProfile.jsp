<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

<head>
  <meta charset="utf-8" />
  <link rel="apple-touch-icon" sizes="76x76" href="./assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="./assets/img/favicon.png">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <title>
    ExamsVilla : Users
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
  <script>
  	$(document).ready(function(){
  		getUserProfileData();
  		$('#updateUserProfileForm').on('submit', function(){
  			var formInput=$(this).serialize();    
			$.getJSON('updateProfile', formInput,function(data) {
				var str = '';
				if(data.successMessageList != null){
					for(var i in data.successMessageList){
						alert(data.successMessageList[i].successMsg);
					}
				}
				
				getUserProfileData();
				
			});  
			return false; 

  		});
  	});
  	function getUserProfileData(){
  	  $.ajax({
  			type : "POST",
  			url : "getUserProfile",
  			success : function(res) {
  				$('#u_id').val(res.map.userId);
  				$('#u_username').val(res.map.email);
  				$('#u_name').val(res.map.name);
  				$('#u_phone').val(res.map.phone);
  			},
  			error : function(res) {
  				$('.err').html("No data found..!!");
  				$('.err').show();
  			}
  		});
    }
  	
  </script>
</head>

<body class="">
<input type="hidden" id="pageId" value="user" />
<input type="hidden" id="page" value="User Profile" />
<s:hidden key="login_id" id="login_id" />
<s:hidden key="email_id" id="email_id" />

  <div class="wrapper ">
  <jsp:include page="adminSideBar.jsp"></jsp:include>
    <div class="main-panel">
      <jsp:include page="adminDashboardTopNav.jsp"></jsp:include>
      <!-- <div class="panel-header panel-header-sm">


</div> -->
      <div class="content">
        <div class="row">
          <div class="col-md-8">
                        <div class="card card-user">
              <div class="card-header">
                <h5 class="card-title">Profile</h5>
              </div>
              <div class="card-body">
              
                <form action="" method="post" id="updateUserProfileForm">
                <input type="hidden" id="u_id" name="userBean.user_id"/>
                  <div class="row">
                  	<div class="error-div" style="display:none;">
                  		<div class="err" style="padding: 0.5rem; border: 1px solid red;"></div>
                  	</div>
                    <div class="col-md-5 pr-1">
                      <div class="form-group">
                        <label>Username (disabled)</label>
                        <input type="text" class="form-control" name="userBean.email_id" placeholder="Username" id="u_username" disabled />
                      </div>
                    </div>
                    <div class="col-md-3 px-1">
                      <div class="form-group">
                        <label>Name</label>
                          <input type="text" class="form-control" name = "userBean.name" placeholder="Name" id="u_name" />
                      </div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-md-6 pr-1">
                      <div class="form-group">
                        <label>Password</label>
                        <input type="password" class="form-control" name="userBean.password" placeholder="Password" >
                      </div>
                    </div>
                    <div class="col-md-6 pl-1">
                      <div class="form-group">
                        <label>Re-type Password</label>
                        <input type="password" class="form-control"  placeholder="Confirm Password" >
                      </div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-md-6 pr-1">
                      <div class="form-group">
                        <label>Phone</label>
                        <input type="text" class="form-control" placeholder="Phone" name="userBean.phone_number" id="u_phone" />
                      </div>
                    </div>
                  </div>
                  
                  <div class="row">
                    <div class="update ml-auto mr-auto">
                      <button type="submit" class="btn btn-primary btn-round">Update Profile</button>
                    </div>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
      <jsp:include page="adminDashboardFooter.jsp" />
    </div>
  </div>
  <form method="post" action="" id="getUserDataForm">
  	<input type="hidden" id="email_id">
  </form>
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
</body>

</html>
