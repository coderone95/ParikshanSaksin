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
    <!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css" integrity="sha256-mmgLkCYLUQbXn0B1SRqzHar6dCnv9oZFPEC1g1cwlkk=" crossorigin="anonymous" /> -->
	<!-- page-wrapper -->
	<script src="./assets/js/core/jquery.min.js"></script>
	<script src="./assets/js/bootstrap-select.min.js"></script>
	<script src="./assets/js/core/popper.min.js"></script>
	<script src="./assets/js/core/bootstrap.min.js"></script>
	<!--  Candidate Panel Sources -->
	<link href="./assets/css/candidate/candidatePanel.css" rel="stylesheet" />
	<script src="./assets/js/candidate/candidatePanel.js"></script>
	<!--  Instructions Page sources  -->
	<link href="./assets/css/candidate/examSet.css" rel="stylesheet" />
	<script src="./assets/js/candidate/examSet.js"></script>
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
          <li>
            <a href="testInstructions">
              <i class="fa fa-book"></i>
              <span>Exam Instructions</span>
            </a>
          </li>
          <s:if test="%{hasExamStarted == 'YES'}">
          <li class="sidebar-dropdown">
            <a href="#">
              <i class="fa fa-newspaper active"></i>
              <span id="exam-sets"class="active">Exam Set</span>
            </a>
            <div class="sidebar-submenu set-question-area-dropdown">
              <ul class="exam-set-dropdown-ul">
                <li class="lis">
                    <a href="#">
                        <span class="exam-set-name">Set 1</span>
                      </a>
                </li>
                <li class="lis">
                    <a href="#">
                        <span class="exam-set-name">Set 2</span>
                      </a>
                </li>
                <li class="lis"> 
                    <a href="#">
                        <span class="exam-set-name">Set 3</span>
                      </a>
                </li>
              </ul>
            </div>
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
    <div class="container-fluid" id="exam-set-container">
        <div class="row exam-set-row">
        </div>
    </div>
    
  </main>
  <!-- page-content" -->
</div>
<!-- <div class="progress mt-1 " data-height="8" style="height: 8px;">
                        <div class="progress-bar l-bg-cyan" role="progressbar" data-width="25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" style="width: 25%;"></div>
                    </div> -->
</body>
</html>