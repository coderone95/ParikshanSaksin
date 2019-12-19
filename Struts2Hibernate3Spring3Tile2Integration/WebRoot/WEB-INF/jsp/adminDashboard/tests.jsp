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
<script src="./assets/js/common.js"></script>
<link href="./assets/css/dashboard-common.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.15/css/bootstrap-multiselect.css" type="text/css">
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.15/js/bootstrap-multiselect.min.js"></script>

<script>
var isAlreadyChecked = false;
var isSelectedAllCheckBox = false;
$(document).ready(function () {
	 $('#availableGroups').multiselect({
         includeSelectAllOption: true,
         buttonWidth: 250,
         enableFiltering: true     
     });
	 
	$('#selectAll').on('click',function(){
		if(!isAlreadyChecked){
			$('.selectQuestionCheckBox').each(function(){
				$(this).prop( "checked", true );
			});
			isAlreadyChecked = true;
			isSelectedAllCheckBox = true;
		}else{
			$('.selectQuestionCheckBox').each(function(){
				$(this).prop( "checked", false );
			});
			isAlreadyChecked = false;
		}
			
	});
	
	$('#summernote').summernote({
		height: 300,
		popover: {
	         image: [],
	         link: [],
	         air: []
	       }
	});
	
	getAllTests();
	getAllGroups();
	
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

       /*  $(".form-group").removeClass("has-error");
        for (var i = 0; i < curInputs.length; i++) {
            if (!curInputs[i].validity.valid) {
                isValid = false;
                $(curInputs[i]).closest(".form-group").addClass("has-error");
            }
        }
 */		
 		
        if (isValid) nextStepWizard.removeAttr('disabled').trigger('click');
    });
    
    allPrevBtn.click(function () {
        var curStep = $(this).closest(".setup-content"),
            curStepBtn = curStep.attr("id"),
            nextStepWizard = $('div.setup-panel div a[href="#' + curStepBtn + '"]').parent().prev().children("a"),
            curInputs = curStep.find("input[type='text']"), 
            isValid = true;

        //$(".form-group").removeClass("has-error");
        if (isValid) nextStepWizard.removeAttr('disabled').trigger('click'); 
    });
    

    $('div.setup-panel div a.btn-success').trigger('click');
});

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
function getAllGroups(){
	$('#groups-table-body').html('');
	$.ajax({
		type : "POST",
		url : "getAllGroupsInfo",
		success : function(itr) {
			var str = '';
			if (itr.groupList != null && itr.groupList.length > 0) {
				for (var i = 0; i < itr.groupList.length; i++) {
					var groupID = itr.groupList[i].group_id;
					var groupName = itr.groupList[i].group_name;
					str += '<tr id="group-'+groupID+'">'
						+'<td><input type="checkbox" class="selectQuestionCheckBox" value ="'+groupID+'" /></td>'
						+'<td><a href="#" onclick="viewGroupDetails('+groupID+',\''+groupName+'\');">' + groupID + '</a></td>'
						+'<td>'+ groupName + '</td>'
						+'</tr>';
				}
				$('#groups-table-body').append(str);

			}else{
				str += '<div class="text-center"> No record found </div>';
				$('#groups-table-body').append(str);
			}

		},
		error : function(itr) {
			alert("No values found..!!");
		}
	});
}

function createTest(){
	var testName = $('#testName').val();
	var testkey = $('#testkey').val();
	var accessKey = $('#accessKey').val();
	var testInstructionsHtmlCode = $('#summernote').summernote('code');
	var groupIDs = [];
	var hrs = $('#hrs').val();
	var mins = $('#mins').val();
	var secs = $('#secs').val();
	var startOn = $('#startOn').val()+':00';
	var endOn = $('#endOn').val()+':00';
	var passingCriteria = $('#passingCriteria').val();
	if(hrs == ''){
		$('#hrs').val('0');
	}else if(mins == ''){
		$('#mins').val('0');
	}else if(secs == ''){
		$('#secs').val('0');
	}
	$('.selectQuestionCheckBox').each(function(){
		if($(this).prop('checked') == true){
			groupIDs.push($(this).val());
		}
	});
	var data = {
			testName: testName,
			testkey:testkey,
			accessKey:accessKey,
			groupIDs:groupIDs,
			startOn: startOn,
			endOn : endOn,
			hrs : hrs,
			mins : mins,
			secs : secs,
			passingCriteria : passingCriteria,
			testInstructionsHtmlCode: testInstructionsHtmlCode
	};
	$.ajax({
		type : "POST",
		url : "createTest",
		dataType: 'json',
		data: JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		success : function(itr) {
			if(itr.res != null){
				var status = itr.res.status;
				if(status == 200){
					alert(itr.res.message);
					getAllTests();
					$('.add-one-more').remove();
					$('#last-step').append('<a href="testsPage" class="btn btn-primary pull-right add-one-more">Add One More</a>');
				}else if(status == 403){
					alert(itr.res.message);
				}
			}
		},
		error : function(itrr) {
			alert("Error occurred while creating test..!!");
		}
	});
}
function formatDateTime(date) {
	  var day = date.getDate();
	  var monthIndex = date.getMonth();
	  var year = date.getFullYear();
	  var min = date.getMinutes();
	  var hours = date.getHours();
	  var sec = date.getSeconds();

	  //return day + ' ' + monthNames[monthIndex] + ' ' + year;
	  return year+'-'+monthIndex+'-'+day+' '+hours+':'+min+':'+sec;
	}
function getAllTests() {
	$('#tests-table-body').html('');
	$.ajax({
		type : "POST",
		url : "getAllTests",
		success : function(itr) {
			var str = '';
			if (itr.testList != null && itr.testList.length > 0) {
				for (var i = 0; i < itr.testList.length; i++) {
					var testID = itr.testList[i].test_id;
					var testName = itr.testList[i].test_name;
					var testKey = itr.testList[i].test_key;
					var accessKey = itr.testList[i].access_key;
					var isLive  = itr.testList[i].is_live;
					var liveRes = '';
					if(isLive == 1){
						liveRes = '<i class="fa fa-hourglass-start text-success"></i>';
					}else{
						liveRes = '<i class="fa fa-hourglass-o text-warning"></i>';
					}
					var createdOn = formatDate(new Date(itr.testList[i].created_on));
					var updatedOn = formatDate(new Date(itr.testList[i].updated_on));
					var createdBy = itr.testList[i].created_by;
					var uddatedBy = itr.testList[i].updated_by;
					str += '<tr id="test-'+testID+'">'
						+'<td>'+testID+'</td>'
						+'<td>'+testName+'</td>'
						+'<td>'+testKey+'</td>'
						+'<td><input type="password" class="access-key-value" id="access-key-'+testID+'" value="'+accessKey+'" /><i class="fa fa-eye" onclick="toggleShow(this,'+testID+');"></i></td>'
						+'<td>'+liveRes+'</td>'
						+'<td>'+createdOn+'</td>'
						+'<td>'+updatedOn+'</td>'
						+'<td>'+createdBy+'</td>'
						+'<td>'+uddatedBy+'</td>'
						+'<td><i class="fa fa-trash text-danger delete" onclick="deleteThisTest('+testID+');"></i>'
						+'<i class="fa fa-pencil text-primary edit" onclick="updateTheTest('+testID+',\''+testName+'\');"></i>'
						+'</td>'
						+'</tr>';
					
				}
				$('#tests-table-body').append(str);

			}else{
				str += '<div class="text-center"> No record found </div>';
				$('#tests-table-body').append(str);
			}

		},
		error : function(itr) {
			alert("No values found..!!");
		}
	});
}
function deleteThisTest(testID){
	$('#deleteModal').modal('show');
	$('#deleteBtn').removeAttr('onclick');
	$('#deleteBtn').attr('onclick','deleteTheTest('+testID+');');
}
function deleteTheTest(testID){
	
	var data = {
		testID: testID
	};
	$.ajax({
		type : "POST",
		url : "deleteTest",
		dataType: 'json',
		data: JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		success : function(itr) {
			$('#test-'+testID).fadeTo("slow",0.7, function(){
	            $(this).remove();
	        })
	        $('#deleteModal').modal('hide');
		},
		error : function(itrr) {
			alert("Error occurred while creating test..!!");
		}
	});
}

function updateTheTest(testID,testName){
	localStorage.removeItem("selectedTestName");
	localStorage.setItem("selectedTestName",testName);
	window.location.href = "updateTestPage.action?testID="+testID;
}
function toggleShow(ths, testID){
	if($(ths).hasClass('fa-eye')){
		$('#access-key-'+testID).removeAttr('type');
		$('#access-key-'+testID).attr('type','text');
		$(ths).removeClass('fa-eye');
		$(ths).addClass('fa-eye-slash');
	}else{
		$('#access-key-'+testID).removeAttr('type');
		$('#access-key-'+testID).attr('type','password');
		$(ths).removeClass('fa-eye-slash');
		$(ths).addClass('fa-eye');
	}
}
</script>
<style>
.padding-0-6-rem {
	padding: 0.6rem;
}
.dropdown-menu li .checkbox {
    font-size: 14px;
}
.multiselect-container li.multiselect-filter .input-group .input-group-addon{
	display:none;
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

.table>thead>tr>th, .table>tbody>tr>th, .table>tfoot>tr>th, .table>thead>tr>td, .table>tbody>tr>td, .table>tfoot>tr>td {
	padding: 0 !important;
	vertical-align: unset !important;
}
.table td, .table th {
	padding: 0 !important;
}
</style>
</head>

<body class="">
	<input type="hidden" id="pageId" value="tests" />
	<input type="hidden" id="page" value="Tests" />
	<s:hidden key="loginId" />

	<div class="wrapper ">
		<jsp:include page="adminSideBar.jsp"></jsp:include>
		<div class="main-panel">
			<jsp:include page="adminDashboardTopNav.jsp"></jsp:include>
			<div class="content">
				<div class="row">
					<div class="col-md-7">
						<div class="card">
				              <div class="card-header"></div>
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
								             <div class="stepwizard-step col-xs-3"> 
								                <a href="#step-9" type="button" class="btn btn-default btn-circle" disabled="disabled">9</a>
								                <p><small>Cargo</small></p>
								            </div>
								        </div>
								    </div>
								    <!-- <form role="form"> -->
								        <div class="panel panel-primary setup-content" id="step-1">
								            <div class="panel-heading">
								                 <h3 class="panel-title">Create Test</h3>
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
								                 <h3 class="panel-title">Create Test</h3>
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
								                 <h3 class="panel-title">Create Test</h3>
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
								                 <h3 class="panel-title">Create Test</h3>
								            </div>
								            <div class="panel-body">
								                <div class="form-group">
								                    <label class="control-label">Time</label>
								                    <input type="number" min="0" required="required" class="form-control" id="hrs" value="0" placeholder="Hours" /><br/>
								                    <input type="number" min="0" max="60" required="required" class="form-control" id="mins" value="0"  placeholder="Minutes" /><br/>
								                    <input type="number" min="0" max="60" required="required" class="form-control" id="secs" value="0" placeholder="Seconds" />
								                </div>
								                <button class="btn btn-primary nextBtn pull-right">Next</button>
								                <button class="btn btn-warning prevBtn pull-right">Prev</button>
								            </div>
								        </div>
								         <div class="panel panel-primary setup-content" id="step-5">
								            <div class="panel-heading">
								                 <h3 class="panel-title">Create Test</h3>
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
								                 <h3 class="panel-title">Create Test</h3>
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
								                 <h3 class="panel-title">Create Test</h3>
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
								                 <h3 class="panel-title">Create Test</h3>
								            </div>
								            <div class="panel-body">
								            	<s:select list="testMap" name="group-selected" id="availableGroups" multiple="true" />
												 <div class="table-responsive" style="max-height:300px;">
					                  				<table class="table">
					                    				<thead class=" text-primary">
					                    						<th><input type="checkbox" id="selectAll" /></th>
					                      						<th>Group ID</th>
																<th>Group Name</th>
					                    				</thead>
								                    <tbody id="groups-table-body">
								                    </tbody>
								                  </table>
								                </div>
								                <button class="btn btn-primary nextBtn pull-right">Next</button>
								                <button class="btn btn-warning prevBtn pull-right">Prev</button>
								            </div>
								        </div>
								        
								        <div class="panel panel-primary setup-content" id="step-9">
								            <div class="panel-heading">
								                 <h3 class="panel-title">Create Test</h3>
								            </div>
								            <div class="panel-body" id="last-step">
								                <div class="form-group">
								                    <label class="control-label">Test Instructions</label>
								                    <div id="summernote"></div>
								                </div>
								                <button class="btn btn-success pull-right" onclick="createTest();">Finish!</button>
								                <button class="btn btn-warning prevBtn pull-right">Prev</button>
								            </div>
								        </div>
								   <!--  </form> -->
						   		</div>
				           </div>
					</div>
					<div class="col-md-12">
			           <div class="card">
			              <div class="card-header">
						  		<h4>All Tests</h4>
						  </div>
			              <div class="card-body" id="tests-card-body">
			              	<div class="table-responsive" style="max-height:500px;">
                  				<table class="table ">
                    				<thead class=" text-primary">
                      						<th> ID </th>
											<th>Name</th>
											<th>Test Key</th>
											<th>Access Key</th>
											<th>Live</th>
											<th>Created On</th>
											<th>Updated On</th>
											<th>Created By</th>
											<th>Updated By</th>
											<th>Action</th>
                    				</thead>
			                    <tbody id="tests-table-body">
			                    
			                    </tbody>
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
