<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>




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
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no"
	name="viewport" />

<!-- jQuery library -->
<%-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> --%>
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
<script src="./assets/js/summernote.js"></script>
<link href="./assets/css/summernote.css" rel="stylesheet" />
<link href="./assets/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet" />
<link href="./assets/css/dashboard-common.css" rel="stylesheet" />
<script src="./assets/js/common.js"></script>
<script>
var isAlreadyChecked = false;
var isSelectedAllCheckBox = false;
$(document).ready(function () {
	getTestInfo();
	getAddedGroupsForSelectedTest();
	getAvailableGroupsForSelectedTest();
	$('#summernote').summernote({
		height: 300,
		popover: {
	         image: [],
	         link: [],
	         air: []
	       }
	});
	
	$('#selectAll').on('click',function(){
		if(!isAlreadyChecked){
			$('.selectGroupCheckBox').each(function(){
				$(this).prop( "checked", true );
			});
			isAlreadyChecked = true;
			isSelectedAllCheckBox = true;
		}else{
			$('.selectGroupCheckBox').each(function(){
				$(this).prop( "checked", false );
			});
			isAlreadyChecked = false;
		}
			
	});
	
	//$('#expireDateTime').datetimepicker();
	$('#startOn').datetimepicker();
	$('#endOn').datetimepicker();
	
	//$('#summernote').summernote('code')
	/* $('.note-insert .note-icon-picture').parent().remove(); */
	$('.note-view .note-icon-arrows-alt').parent().remove();
	
	var navListItems = $('div.setup-panel div a'),
	    allWells = $('.setup-content'),
	    allNextBtn = $('.nextBtn'),
	    allPrevBtn = $('.prevBtn');
	
	allWells.hide();
	
	navListItems.click(function (e) {
	    e.preventDefault();
	    var $target = $($(this).attr('href')),
	        $item = $(this);
	
	    if (!$item.hasClass('disabled')) {
	        navListItems.removeClass('btn-success').addClass('btn-default');
	        $item.addClass('btn-success');
	        allWells.hide();
	        $target.show();
	    }
	});
	
	allNextBtn.click(function () {
	    var curStep = $(this).closest(".setup-content"),
	        curStepBtn = curStep.attr("id"),
	        nextStepWizard = $('div.setup-panel div a[href="#' + curStepBtn + '"]').parent().next().children("a"),
	        curInputs = curStep.find("input[type='text']")
	        isValid = true;
	
	    if (isValid) nextStepWizard.removeAttr('disabled').trigger('click');
	});
	
	allPrevBtn.click(function () {
	    var curStep = $(this).closest(".setup-content"),
	        curStepBtn = curStep.attr("id"),
	        nextStepWizard = $('div.setup-panel div a[href="#' + curStepBtn + '"]').parent().prev().children("a"),
	        curInputs = curStep.find("input[type='text']"), 
	        isValid = true;
	
	    if (isValid) nextStepWizard.removeAttr('disabled').trigger('click'); 
	});
	
	
	$('div.setup-panel div a.btn-success').trigger('click');
		
});

function getAddedGroupsForSelectedTest(){
	$('#added-group-table-body').html('');
	$('#total-added-groups').text('0');
	var testID = $('#testID').val();
	var data = {
			testID : testID
	};
	$.ajax({
		type : "POST",
		url : "getAddedGroupsForSelectedTest",
		dataType: 'json',
		data: JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		success : function(itr) {
			str = '';
			if(itr.addedGroupsList !=null && itr.addedGroupsList.length > 0){
				$('#total-added-groups').text(itr.addedGroupsList.length);
				for(var i = 0 ; i < itr.addedGroupsList.length; i++){
					var groupID = itr.addedGroupsList[i].group_id;
					var groupName = itr.addedGroupsList[i].group_name;
					str += '<tr>'
						+'<td>'+groupID+'</td>'
						+'<td>'+groupName+'</td>'
						+'<td><button class="btn btn-outline-danger" onclick="removeThisGroup('+testID+','+groupID+');"><i class="fa fa-trash"></i></button></td>'
						+'</tr>';
				}
				$('#added-group-table-body').append(str);
			}else{
				str = '<div class="text-center"> No Groups are added!!</div>';
				$('#added-group-table-body').append(str);
			}
		},
		error : function(itrr) {
			alert("Error occurred while fetching added groups..!!");
		}
	});
}
function removeThisGroup(testID,groupId){
	var data = {
			testID : testID,
			groupId : groupId
	};
	$.ajax({
		type : "POST",
		url : "removeSelectedGroupFromSelectedTest",
		dataType: 'json',
		data: JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		success : function(itr) {
			//getAddedGroupsForSelectedTest();
			getAvailableGroupsForSelectedTest();
			getAddedGroupsForSelectedTest();
		},
		error : function(itrr) {
			alert("Error occurred while fetching added groups..!!");
		}
	});
}
function getAvailableGroupsForSelectedTest(){
	$('#available-group-table-body').html('');
	var testID = $('#testID').val();
	var data = {
			testID : testID
	};
	$.ajax({
		type : "POST",
		url : "getAvailableGroupsForSelectedTest",
		dataType: 'json',
		data: JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		success : function(itr) {
			str = '';
			if(itr.availableGroupsList !=null && itr.availableGroupsList.length > 0){
				$('#total-available-groups').text(itr.availableGroupsList.length);
				for(var i = 0 ; i < itr.availableGroupsList.length; i++){
					var groupID = itr.availableGroupsList[i].group_id;
					var groupName = itr.availableGroupsList[i].group_name;
					str += '<tr><td><input type="checkbox" class="selectGroupCheckBox" value ="'+groupID+'" /></td>'
						+'<td>'+groupID+'</td>'
						+'<td>'+groupName+'</td>'
						+'</tr>';
				}
				$('#available-group-table-body').append(str);
			}else{
				str = '<div class="text-center"> No Record found!!</div>';
				$('#available-group-table-body').append(str);
			}
		},
		error : function(itrr) {
			alert("Error occurred while fetching added groups..!!");
		}
	});
}

function getTestInfo(){
	var testID = $('#testID').val();
	var data = {
			testID : testID
	};
	$.ajax({
		type : "POST",
		url : "getTestInfoForSelectedID",
		dataType: 'json',
		data: JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		success : function(itr) {
			if (itr.testBoList != null && itr.testBoList.length > 0) {
				var testBo = itr.testBoList[0];
				var testName = testBo.test_name;
				var startOn = testBo.startOn;
				var endOn = testBo.endOn;
				var testKey = testBo.test_key;
				var testAccessKey = testBo.access_key;
				var testTime = testBo.test_time;
				var testInstructions = testBo.test_instructions;
				var passingCriteria = testBo.passingCriteria;
				$('#testName').val(testName);
				if(startOn != null){
					startOn = startOn.substring(0, startOn.length - 5);
				}
				if(endOn != null){
					endOn = endOn.substring(0, endOn.length - 5);
				}
				$('#startOn').val(startOn);
				$('#endOn').val(endOn);
				$('#testkey').val(testKey);
				$('#accessKey').val(testAccessKey);
				var testTimeObj = secondsToTime(testTime);
				$('#hrs').val(testTimeObj.h);
				$('#mins').val(testTimeObj.m);
				$('#secs').val(testTimeObj.s);
				//$('#testTime').val(testTime);
				$('#passingCriteria').val(passingCriteria);
				$('#summernote').summernote('code', testInstructions);
			}
		},
		error : function(itrr) {
			alert("Error occurred while fetching test..!!");
		}
	});
	
}

function secondsToTime(secs)
{
    var hours = Math.floor(secs / (60 * 60));

    var divisor_for_minutes = secs % (60 * 60);
    var minutes = Math.floor(divisor_for_minutes / 60);

    var divisor_for_seconds = divisor_for_minutes % 60;
    var seconds = Math.ceil(divisor_for_seconds);

    var obj = {
        "h": hours,
        "m": minutes,
        "s": seconds
    };
    return obj;
}

function randomString() {
	var chars = "";
	chars = chars + "ABCDEFGHIJKLMNOPQRSTUVWXTZ";
	chars = chars + "abcdefghiklmnopqrstuvwxyz";	
	chars = chars + "0123456789";
	chars = chars + "!#$%&@";
	
	var string_length = 10;
	var randomstring = '';
	for (var i=0; i<string_length; i++) {
		var rnum = Math.floor(Math.random() * chars.length);
		randomstring += chars.substring(rnum,rnum+1);
	}
	console.log(randomstring);
	$('#accessKey').val(randomstring);
}

function updateTest(){
	var testID = $('#testID').val();
	var testName = $('#testName').val();
	var startOn = '';
	if($('#startOn').val() != ''){
		startOn = $('#startOn').val()+':00';
	}
	var endOn = '';
	if($('#endOn').val() != ''){
		endOn = $('#endOn').val()+':00';
	}
	var testKey = $('#testkey').val();
	var testTime = $('#testTime').val();
	var testAccessKey = $('#accessKey').val();
	var passingCriteria = $('#passingCriteria').val();
	var hrs = $('#hrs').val();
	var mins = $('#mins').val();
	var secs = $('#secs').val();
	var testInstructions = $('#summernote').summernote('code');
	if(hrs == ''){
		$('#hrs').val('0');
	}else if(mins == ''){
		$('#mins').val('0');
	}else if(secs == ''){
		$('#secs').val('0');
	}
	var data = {
			testID : testID,
			testName : testName,
			testKey: testKey,
			testAccessKey: testAccessKey,
			startOn : startOn,
			endOn : endOn,
			hrs: hrs,
			mins : mins,
			secs : secs,
			passingCriteria : passingCriteria,
			testInstructions : testInstructions
	};
	$.ajax({
		type : "POST",
		url : "updateTest",
		dataType: 'json',
		data: JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		success : function(itr) {
			if(itr.errorMsg == null || itr.errorMsg == ''){
				alert('Updated test successfully!!');	
			}else{
				alert(itr.errorMsg);
			}
		},
		error : function(itrr) {
			alert("Error occurred while updating the test..!!");
		}
	});
}

function addSelectedGroupsToTest(){
	var groupIDs = [];
	var testID = $('#testID').val();
	$('.selectGroupCheckBox').each(function(){
		if($(this).prop( "checked") == true ){
			groupIDs.push($(this).attr('value'));
		}
	});
	var data = {
		groupIDs : groupIDs,
		testID: testID	
	};
	$.ajax({
		type : "POST",
		url : "addSelectedGroupsToTest",
		dataType: 'json',
		data: JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		success : function(itr) {
			alert("Groups added");
			getAddedGroupsForSelectedTest();
			getAvailableGroupsForSelectedTest();
		},
		error : function(itrr) {
			alert("Error occurred while updating the test..!!");
		}
	});
}
</script>
<style>
.padding-0-6-rem {
	padding: 0.6rem;
}
</style>


<style type="text/css">
.errorDiv {
	color: red;
}

.error-msg {
	color: red
}

.success-msg {
	color: #008000;
}

.error-msg b {
	margin-bottom: 1rem;
	padding: 0.1rem;
	border: 1px solid red;
}

.success-msg b {
	margin-bottom: 1rem;
	padding: 0.1rem;
	border: 1px solid #008000;
}

.padding-0-6-rem {
	padding: 0.6rem;
}

.custom-switch {
	cursor: pointer;
	float: right;
	font-size: 2rem;
}

.fa-toggle-on, .fa-toggle-off {
	color: #51cbce;
}

#updateOptions li {
	list-style: none;
}
.form-group input[type=file]{
	opacity: 1 !important;
}
.fa-eye, .fa-eye-slash{
	margin-left: 0.2rem;
}
.access-key-value{
	background-color: #ece5e5;
    border: 1px solid #DDDDDD;
    border-radius: 4px;
    color: #0c0c0b;
    padding: 0.2rem;
    font-size: 12px;
} 
.datetimepicker{
	 border: 1px solid #000000;
}
</style>
<style>
/* Latest compiled and minified CSS included as External Resource*/

/* Optional theme */

/*@import url('//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-theme.min.css');*/

.stepwizard-step p {
    margin-top: 0px;
    color:#666;
}
.stepwizard-row {
    display: table-row;
}
.stepwizard {
    display: table;
    width: 100%;
    position: relative;
}
.stepwizard-step button[disabled] {
    /*opacity: 1 !important;
    filter: alpha(opacity=100) !important;*/
}
.stepwizard .btn.disabled, .stepwizard .btn[disabled], .stepwizard fieldset[disabled] .btn {
    opacity:1 !important;
    color:#bbb;
}
.stepwizard-row:before {
    top: 14px;
    bottom: 0;
    position: absolute;
    content:" ";
    width: 100%;
    height: 1px;
    background-color: #ccc;
    z-index: 0;
}
.stepwizard-step {
    display: table-cell;
    text-align: center;
    position: relative;
}
.btn-circle {
    width: 30px;
    height: 30px;
    text-align: center;
    padding: 6px 0;
    font-size: 12px;
    line-height: 1.428571429;
    border-radius: 15px;
}
.note-editor .note-toolbar .btn-group > .btn{
	background-color:#FBFBFB !important;
	color:#0F0E0E !important;
}
.note-btn-group .dropdown-menu > li a {
	color: #0e0f0f !important;
}
.datetimepicker {
	font-size: 1.5rem !important;
}

.delete , .edit{
	padding: 1.5rem;
    cursor: pointer;
}
</style>
</head>

<body class="">
	<input type="hidden" id="pageId" value="tests" />
	<input type="hidden" id="page" value="Update Test" />
	<s:hidden key="loginId" />
	<s:hidden key="testID" />

	<div class="wrapper ">
		<jsp:include page="adminSideBar.jsp"></jsp:include>
		<div class="main-panel">
			<jsp:include page="adminDashboardTopNav.jsp"></jsp:include>
			<div class="content">
				<div class="row">
					<div class="col-md-7">
						<div class="card">
				              <div class="card-header"><a href="testsPage"><i class="fa fa-arrow-left"></i> Back </a></div>
				              <div class="card-body">
									 <div class="stepwizard">
								        <div class="stepwizard-row setup-panel" style="display:none">
								            <div class="stepwizard-step col-xs-3"> 
								                <a href="#step-1" type="button" class="btn btn-success btn-circle">1</a>
								                <p><small>Shipper</small></p>
								            </div>
								            <div class="stepwizard-step col-xs-3"> 
								                <a href="#step-2" type="button" class="btn btn-default btn-circle" disabled="disabled">2</a>
								                <p><small>Destination</small></p>
								            </div>
								            <div class="stepwizard-step col-xs-3"> 
								                <a href="#step-3" type="button" class="btn btn-default btn-circle" disabled="disabled">3</a>
								                <p><small>Schedule</small></p>
								            </div>
								            <div class="stepwizard-step col-xs-3"> 
								                <a href="#step-4" type="button" class="btn btn-default btn-circle" disabled="disabled">4</a>
								                <p><small>Cargo</small></p>
								            </div>
								            <div class="stepwizard-step col-xs-3"> 
								                <a href="#step-5" type="button" class="btn btn-default btn-circle" disabled="disabled">5</a>
								                <p><small>Cargo</small></p>
								            </div>
								            <div class="stepwizard-step col-xs-3"> 
								                <a href="#step-6" type="button" class="btn btn-default btn-circle" disabled="disabled">6</a>
								                <p><small>Cargo</small></p>
								            </div>
								             <div class="stepwizard-step col-xs-3"> 
								                <a href="#step-7" type="button" class="btn btn-default btn-circle" disabled="disabled">7</a>
								                <p><small>Cargo</small></p>
								            </div>
								            <div class="stepwizard-step col-xs-3"> 
								                <a href="#step-8" type="button" class="btn btn-default btn-circle" disabled="disabled">8</a>
								                <p><small>Cargo</small></p>
								            </div>
								        </div>
								    </div>
								    <!-- <form role="form"> -->
								        <div class="panel panel-primary setup-content" id="step-1">
								            <div class="panel-heading">
								                 <h3 class="panel-title">Update Test</h3>
								            </div>
								            <div class="panel-body">
								                <div class="form-group">
								                    <label class="control-label">Test Name</label>
								                    <input maxlength="100" type="text" required="required" class="form-control" id="testName" placeholder="Enter test name" />
								                </div>
								                <button class="btn btn-primary nextBtn pull-right">Next</button>
								            </div>
								        </div>
								        <div class="panel panel-primary setup-content" id="step-2">
								            <div class="panel-heading">
								                 <h3 class="panel-title">Update Test</h3>
								            </div>
								            <div class="panel-body">
								                <div class="form-group">
								                    <label class="control-label">Starts On</label>
								                    <input maxlength="100" type="text" required="required" class="form-control" id="startOn" placeholder="Exam starts on" />
								                </div>
								                <button class="btn btn-primary nextBtn pull-right">Next</button>
								                <button class="btn btn-warning prevBtn pull-right">Prev</button>
								            </div>
								        </div>
								        <div class="panel panel-primary setup-content" id="step-3">
								            <div class="panel-heading">
								                 <h3 class="panel-title">Update Test</h3>
								            </div>
								            <div class="panel-body">
								                <div class="form-group">
								                    <label class="control-label">Ends On</label>
								                    <input maxlength="100" type="text" required="required" class="form-control" id="endOn" placeholder="Exam ends on" />
								                </div>
								                <button class="btn btn-primary nextBtn pull-right">Next</button>
								                <button class="btn btn-warning prevBtn pull-right">Prev</button>
								            </div>
								        </div>
								        <div class="panel panel-primary setup-content" id="step-4">
								            <div class="panel-heading">
								                 <h3 class="panel-title">Update Test</h3>
								            </div>
								            <div class="panel-body">
								                <div class="form-group">
								                    <label class="control-label">Time</label>
								                    <input type="number" min="0" required="required" class="form-control"  value="0" id="hrs" placeholder="Hours" /><br/>
								                    <input type="number" min="0" max="60" required="required" class="form-control"  value="0" id="mins" placeholder="Minutes" /><br/>
								                    <input type="number" min="0" max="60" required="required" class="form-control"  value="0" id="secs" placeholder="Seconds" />
								                </div>
								                <button class="btn btn-primary nextBtn pull-right">Next</button>
								                <button class="btn btn-warning prevBtn pull-right">Prev</button>
								            </div>
								        </div>
								         <div class="panel panel-primary setup-content" id="step-5">
								            <div class="panel-heading">
								                 <h3 class="panel-title">Update Test</h3>
								            </div>
								            <div class="panel-body">
								                <div class="form-group">
								                    <label class="control-label">Test Key</label>
								                    <input maxlength="100" type="text" required="required" class="form-control" id="testkey" placeholder="Enter test key" />
								                </div>
								                <button class="btn btn-primary nextBtn pull-right">Next</button>
								                <button class="btn btn-warning prevBtn pull-right">Prev</button>
								            </div>
								        </div>
								        <div class="panel panel-primary setup-content" id="step-6">
								            <div class="panel-heading">
								                 <h3 class="panel-title">Update Test</h3>
								            </div>
								            <div class="panel-body">
								                <div class="form-group">
								                    <label class="control-label"></label>
								                    <button class="btn btn-primary" onclick="randomString();">Generate Access Key</button>
								                </div>
								                <div class="form-group">
								                	<label class="control-label">Access Key</label>
								                    <input maxlength="200" type="text" id="accessKey" class="form-control" />
								                </div>
								                <button class="btn btn-primary nextBtn pull-right">Next</button>
								                <button class="btn btn-warning prevBtn pull-right">Prev</button>
								            </div>
								        </div>
								        <div class="panel panel-primary setup-content" id="step-7">
								            <div class="panel-heading">
								                 <h3 class="panel-title">Update Test</h3>
								            </div>
								            <div class="panel-body">
								                <div class="form-group">
								                	<label class="control-label">Minimum Passing Criteria</label>
								                    <input type="number" id="passingCriteria" class="form-control" value="0"/>
								                </div>
								                <button class="btn btn-primary nextBtn pull-right">Next</button>
								                <button class="btn btn-warning prevBtn pull-right">Prev</button>
								            </div>
								        </div>
								        <div class="panel panel-primary setup-content" id="step-8">
								            <div class="panel-heading">
								                 <h3 class="panel-title">Update Test</h3>
								            </div>
								            <div class="panel-body" id="last-step">
								                <div class="form-group">
								                    <label class="control-label">Test Instructions</label>
								                    <div id="summernote"></div>
								                </div>
								                <button class="btn btn-success pull-right" onclick="updateTest();">Update Test!</button>
								                <button class="btn btn-warning prevBtn pull-right">Prev</button>
								            </div>
								        </div>
								   <!--  </form> -->
						   		</div>
				           </div>
					</div>
					<div class="col-md-5">
						<div class="card">
			              <div class="card-header">
						  </div>
			              <div class="card-body" >
			              		<div class="row">
			              			<div class="col-md-12">
			              				<h5 class="text-primary"> Total Added Groups</h5>
			              				<h5 id="total-added-groups">0</h5>
			              			</div>
			              			<div class="col-md-12">
			              				<h5 class="text-primary"> Available Groups</h5>
			              				<h5 id="total-available-groups">0</h5>
			              			</div>
			              		</div>
			              </div>
			           </div>
					</div>
					<div class="col-md-6">
			           <div class="card">
			              <div class="card-header"><h4>Added Groups</h4></div>
			              <div class="card-body">
						       <div class="table-responsive" style="max-height:500px;">
				                  	<table class="table" >
				                  		<thead class=" text-primary">
				                      		<th>Group ID</th>
											<th>Group</th>
											<th>Remove</th>
				                    	</thead>
							            <tbody id="added-group-table-body"></tbody>
							         </table>
						        </div>
						     </div>
						 </div>
					</div>
					<div class="col-md-6">
			           <div class="card">
			              <div class="card-header"><h4>Add Group to Test</h4></div>
			              <div class="card-body">
						      <div class="row">
						            <div class="col-md-8"></div>
							        <div class="col-md-4">
							        <div class="update ml-auto mr-auto">
										<input type="button" style="float:right;" class="btn btn-primary btn-round" onclick ="addSelectedGroupsToTest();" value="Add Selected Groups">
									</div>
								</div>
							</div>
						    <div class="table-responsive" style="max-height:500px;">
			                  	<table class="table">
			                    	<thead class=" text-primary">
			                    		<th><input type="checkbox" id="selectAll" /></th>
			                      		<th>Group ID</th>
										<th>Group</th>
			                    	</thead>
						            <tbody id="available-group-table-body"></tbody>
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
	<!--Delete Modal -->
		  <div class="modal fade" id="deleteModal" role="dialog" style="z-index:99999999;">
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
		      </div>
		    </div>
		  </div> 
	<!--   Core JS Files   -->
	<%-- <script src="./assets/js/core/jquery.min.js"></script> --%>
	<script src="./assets/js/core/popper.min.js"></script>
	<script src="./assets/js/core/bootstrap.min.js"></script>
	<script src="./assets/js/bootstrap-datetimepicker.js"></script>
	
	<!-- Chart JS -->
	<script src="./assets/js/plugins/chartjs.min.js"></script>
	<!--  Notifications Plugin    -->
	<script src="./assets/js/plugins/bootstrap-notify.js"></script>
	<!-- Control Center for Now Ui Dashboard: parallax effects, scripts for the example pages etc -->
	<script src="./assets/js/paper-dashboard.min.js?v=2.0.0"
		type="text/javascript"></script>
</body>

</html>
