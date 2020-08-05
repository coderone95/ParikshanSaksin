<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Parikshan Saksin</title>
    <link href="./assets/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
	<!-- page-wrapper -->
	<script src="./assets/js/core/jquery.min.js"></script>
	<script src="./assets/js/bootstrap-select.min.js"></script>
	<script src="./assets/js/core/popper.min.js"></script>
	<script src="./assets/js/core/bootstrap.min.js"></script>
  <link href="./assets/css/loader.css" rel="stylesheet" />
	<!--  Candidate Panel Sources -->
	<link href="./assets/css/candidate/candidatePanel.css" rel="stylesheet" />
	<script src="./assets/js/candidate/candidatePanel.js"></script>
	<!--  Instructions Page sources  -->
	<link href="./assets/css/candidate/testInstructionsPage.css" rel="stylesheet" />
	<script src="./assets/js/candidate/testInstructionPage.js"></script>
</head>

<body>
<s:hidden key="testID"></s:hidden>
<s:hidden key="loginId"></s:hidden>
<s:hidden key="hasExamStarted"></s:hidden>
<div class="page-wrapper chiller-theme toggled">
  <a id="show-sidebar" class="btn btn-sm btn-dark" href="#">
    <i class="fas fa-bars"></i>
  </a>
  <nav id="sidebar" class="sidebar-wrapper">
    <div class="sidebar-content">
      <div class="sidebar-brand">
        <a href="#">Pariskhan Saksin</a>
        <div id="close-sidebar">
          <i class="fas fa-times"></i>
        </div>
      </div>
      <div class="sidebar-header l-bg-orange">
        <div class="user-pic">
          <img class="img-responsive img-rounded" src="https://raw.githubusercontent.com/azouaoui-med/pro-sidebar-template/gh-pages/src/img/user.jpg"
            alt="User picture">
        </div>
        <div class="user-info">
          <span class="user-name"><s:property value="name"></s:property>
          </span>
          <span class="user-role user-email-id"><s:property value="loginId"/></span>
        </div>
      </div>
      <div class="sidebar-menu">
        <ul>
          <!-- <li class="header-menu">
            <span>Extra</span>
          </li> -->
          <s:if test="%{hasExamStarted == 'YES'}">
          <li>
            <a href="testInstructions">
              <i class="fa fa-book active"></i>
              <span class="active">Exam Instructions</span>
            </a>
          </li>
          </s:if>
          <s:if test="%{hasExamStarted == 'YES'}">
          <li>
            <a href="examSet">
              <i class="fa fa-newspaper"></i>
              <span id="exam-sets">Exam Set</span>
            </a>
          </li>
          </s:if>
          <li>
            <a onclick="clearSessionValues();" href="#">
                <i class="fa fa-power-off"></i>
              <span>Logout</span>
            </a>
          </li>
        </ul>
      </div>
      <!-- sidebar-menu  -->
    </div>
  </nav>
  <!-- sidebar-wrapper  -->
  <main class="page-content">
    <div class="container-fluid" id="exam-instructions-container">
        <div class="card">
          <div class="loaddercontainer instrustions-loader" style="display: none">
                    <div class="lds-ring">
                          <div></div>
                          <div></div>
                          <div></div>
                          <div></div>
                    </div>
                    </div>
            <div class="card-header no-header-bg">
                <p>EXAM INSTRUCTIONS</p>
                <!-- <div class="card-option text-right"><button class="btn btn-info">SUBMIT</button><button type="button" class="btn btn-primary ml-1">
                    <i class="fa fa-hourglass-half"></i> <span class="badge badge-light" id="time">12.45</span>
                </button></div> -->
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-xs-1-12 col-sm-12 col-lg-12">
                        <div class="test-instructions-area">
                            <div class="test-instructions" style="max-height: 500px; overflow: auto;">
                            </div>
                        </div>
                        <s:if test="%{hasExamStarted != 'YES'}">
	                        <div>
	                            <button type="button" id="startTest-btn" class="btn btn-dark btn-block">START EXAM</button>
	                        </div>
	                    </s:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
  </main>
  <!-- page-content" -->
</div>

</body>

</html>