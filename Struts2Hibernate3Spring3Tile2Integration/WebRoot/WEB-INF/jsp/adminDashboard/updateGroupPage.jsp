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
 <sx:head />
<script src="./assets/js/core/jquery.min.js"></script>
<script src="./assets/js/bootstrap-select.min.js"></script>
<script src="./assets/js/common.js"></script>
<link href="./assets/css/dashboard-common.css" rel="stylesheet" />
<style>
	.padding-0-6-rem{
		padding: 0.6rem;
	}
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
.custom-switch{
	cursor:pointer;
	float:right;
	font-size: 2rem;
}
.fa-toggle-on, .fa-toggle-off{
	color:#51cbce;
}
#updateOptions li{
	 list-style: none;
}
</style>
<script>
	var isAlreadyChecked = false;
	var isSelectedAllCheckBox = false;
	$(document).ready(function(){
		var selectedID = $('#selectedId').val();
		getAddedQuestionsForSelectedGroup(selectedID);
		getAvailableQuestionsForSelectedGroup(selectedID);
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
	});
	
	function getAvailableQuestionsForSelectedGroup(selectedGroupID){
		$('#questions-table-body').html('');
		var data = {
				selectedGroupID: selectedGroupID
		};
		$.ajax({
			type : "POST",
			url : "getAvailableQuestionsForSelectedGroup",
			data: JSON.stringify(data),
			dataType: 'json',
			contentType:"application/json;charset=utf-8",
			success : function(itr) {
				var str = '';
				if (itr.availableQuestionsList != null && itr.availableQuestionsList.length > 0) {
					for (var i = 0; i < itr.availableQuestionsList.length; i++) {
						var queID = itr.availableQuestionsList[i].question_id;
						var question = itr.availableQuestionsList[i].question;
						
						str += '<tr><td><input type="checkbox" onclick="addThis('+queID+')" class="selectQuestionCheckBox" value ="'+queID+'" /></td>'
							+'<td>'+queID+'</td>'
							+'<td>'+question+'</td>'
							+'</tr>';
					}
					$('#questions-table-body').append(str);

				}else{
					str += '<div class="text-center"> No record found </div>';
					$('#questions-table-body').append(str);
				}
			},
			error : function(itr) {
				alert("Error while processing the request....!!");
			}
		});
		
	}
	
	function getAddedQuestionsForSelectedGroup(selectedGroupID){
		$('#u-group-questions-table-body').html('');
		$('#selectedGroupID').val(selectedGroupID);
		var data = {
				selectedGroupID: selectedGroupID
		};
		$.ajax({
			type : "POST",
			url : "getAddedQuestionsForSelectedGroup",
			data: JSON.stringify(data),
			dataType: 'json',
			contentType:"application/json;charset=utf-8",
			success : function(itr) {
				var str ='';
				$('#u-group-name').val(localStorage.getItem("selectedGroupName"));
				$('#u-total-que').text(itr.totalQuestionsAddedForSelectGroup);
				if(itr.addedQuestionsList != null && itr.addedQuestionsList.length > 0){
					for(var i = 0 ; i < itr.addedQuestionsList.length;i++){
						var questionID = itr.addedQuestionsList[i].question_id;
						var question = itr.addedQuestionsList[i].question;
						str += '<tr class="added-question ques-'+questionID+'" value="'+questionID+'"><td>'+questionID+'</td><td>'+question+'</td>'
							+'<td><button class="btn btn-outline-danger" onclick="removeThisQuestion('+selectedGroupID+','+questionID+');"><i class="fa fa-trash"></i></button></td>'
							+'</tr>';
					}
					$('#u-group-questions-table-body').append(str);
				}else{
					str = '<div class="text-center"> No Questions are added!!</div>';
					$('#u-group-questions-table-body').append(str);
				}
			},
			error : function(itr) {
				alert("Error while processing the request....!!");
			}
		});
	}
	
	function viewGroupDetails(selectedGroupID){
		$('#group-questions-table-body').html('');
		var data = {
				selectedGId : selectedGroupID,
		};
		$('#viewGroupDetailsModal').modal('show');
		$.ajax({
			type : "POST",
			url : "allAddedQuestionsOfSelectedGroup",
			data: JSON.stringify(data),
			dataType: 'json',
			contentType:"application/json;charset=utf-8",
			success : function(data) {
				var str ='';
				$('#group-name').text('');
				$('#total-que').text(data.totalQuestionsAddedForSelectGroup);
				if(data.groupQuestionInfo != null && data.groupQuestionInfo.length > 0){
					for(var i = 0 ; i < data.groupQuestionInfo.length;i++){
						var questionID = data.groupQuestionInfo[i].question_id;
						var question = data.groupQuestionInfo[i].question;
						str += '<tr><td><a href="#" onclick="showQuestionDetails('+questionID+');">'+questionID+'</a></td><td>'+question+'</td></tr>';
					}
					$('#group-questions-table-body').append(str);
				}else{
					str = '<div class="text-center"> No Questions are added!!</div>';
					$('#group-questions-table-body').append(str);
				}
			},
			error : function(itr) {
				alert("Error while processing the request....!!");
			}
		});
	}
	
	function removeThisQuestion(groupID,questionID){
		$('#deleteModal').modal('show');
		$('#deleteBtn').removeAttr('onclick');
		$('#deleteBtn').attr('onclick','removeSelectedQuestionFromGroup('+groupID+','+questionID+');');
	}
	function removeSelectedQuestionFromGroup(selectedGroupID,questionId){
		var data = {
				selectedGroupID : selectedGroupID,
				questionId : questionId
		};
		$.ajax({
			type : "POST",
			url : "removeSelectedQuestionFromGroup",
			data: JSON.stringify(data),
			dataType: 'json',
			contentType:"application/json;charset=utf-8",
			success : function(itr) {
				$('#deleteModal').modal('hide');
				$('.ques-'+questionId).fadeTo("slow",0.7, function(){
		            $(this).remove();
		            getAddedQuestionsForSelectedGroup(selectedGroupID);
		            getAvailableQuestionsForSelectedGroup(selectedGroupID);
		        })
		       /*  if($('.added-question').length == 0){
					$('#u-group-questions-table-body').append('<div class="text-center"> No Questions are added!!</div>');
				} */
			},
			error : function(itr) {
				alert("Error while processing the request....!!");
			}
		});
	}
	
	function addThis(queID){
		$('#singleQuestionID').val(queID);
	}
	function addSelectedQuestionsToGroup(){
		var selectedGroupID = $('#selectedId').val();
		var selectedQuestionIDs = [];
		
		if(isSelectedAllCheckBox){
			$('.selectQuestionCheckBox').each(function(){
				selectedQuestionIDs.push($(this).val());
			});	
		}else{
			selectedQuestionIDs.push($('#singleQuestionID').val());
		}
		var data = {
				selectedGroupID : selectedGroupID,
				selectedQuestionIDs : selectedQuestionIDs
		};
		$.ajax({
			type : "POST",
			url : "addSelectedQuestionsToGroup",
			data: JSON.stringify(data),
			dataType: 'json',
			contentType:"application/json;charset=utf-8",
			success : function(data) {
				if(data.errorMessagesList != null && data.errorMessagesList.length > 0){
					alert(data.errorMessagesList[0].errorMsg);
				}else{
					alert("Questions added Successfully");
					$('#addQuestionToGroupModal').modal('hide');	
					getAddedQuestionsForSelectedGroup(selectedGroupID);
					getAvailableQuestionsForSelectedGroup(selectedGroupID);
				}
			},
			error : function(itr) {
				alert("Error while processing the request....!!");
			}
		});
	}
	
	function showQuestionDetails(queID){
		getQuestionDetails(queID);
		$('#showQuestionDetailsModal').modal('show');
	}
	function getQuestionDetails(queID){
		$('#optionList').html('');
		$('#answer').html('');
		$('#questionName').text('');
		var data = {
				quesID : queID
		};
		$.ajax({
			type : "POST",
			url : "getQuestionDetails",
			dataType: 'json',
			data: JSON.stringify(data),
			contentType:"application/json;charset=utf-8",
			success : function(itr) {
				if(itr.re.status == 403 && itr.re != null ){
					alert("Unable to fetch question details");
				}else{
					if(itr.questionDetail != null){
						$('#questionName').text(itr.questionDetail.question);
						var str = '';
						var cnt = 65;
						for( var i = 0 ; i < itr.questionDetail.options.length; i++){
							if(itr.questionDetail.answer == itr.questionDetail.options[i]){
								ans = cnt;
							}
							str += '<li>'+itr.questionDetail.options[i]+'</li>';
							cnt++;
						}
						$('#optionList').append(str);
						$('#answer').append('Answer: &#'+ans+';');
					}					
				}
			},
			error : function(itrr) {
				alert("Error occurred while getting question details..!!");
			}
		});
	}
	
	function updateGroupInfo(){
		var groupName = $('#u-group-name').val();
		var groupID = $('#selectedGroupID').val();
		var data = {
				selectedGroupID : groupID,
				groupName : groupName
		};
		$.ajax({
			type : "POST",
			url : "updateGroupInfo",
			dataType: 'json',
			data: JSON.stringify(data),
			contentType:"application/json;charset=utf-8",
			success : function(itr) {
				if(itr.errorMessagesList.length > 0 && itr.errorMessagesList != null){
					alert(itr.errorMessagesList[0].errorMsg);
				}else{
					alert("Group Updated successfully!!");
				}
			},
			error : function(itrr) {
				alert("Error occurred while updating group details..!!");
			}
		});
	}  
	
</script>

</head>

<body class="">
	<input type="hidden" id="pageId" value="groups" />
	<input type="hidden" id="page" value="Groups" />
	<s:hidden id="selectedId" key="selectedGId" /> 
	<div class="wrapper ">
		<jsp:include page="adminSideBar.jsp"></jsp:include>
		<div class="main-panel">
			<jsp:include page="adminDashboardTopNav.jsp"></jsp:include>
			<div class="content">
				<div class="row">
					<div class="col-md-12">
						<div class="card demo-icons">
							<div class="card-header">
								<a href="groups"><i class="fa fa-arrow-left"></i> Back </a>
							</div>
							<div class="card-body">
								<input type="hidden" id="selectedGroupID">
								<div class="row">
									<div class="col-md-4 pr-1">
										<div class="form-group">
											<label>Group</label> 
											<input type="text" class="form-control" name="u-group-name" id="u-group-name" required />
										</div>
									</div>
									<div class="col-md-4 pr-1">
										<div class="form-group">
											<input type="button" style="margin: 24px 1px;" id="updateGroupBtn" class="btn btn-primary btn-round" onclick="updateGroupInfo();" value="Update Group">
										</div>
									</div>
									<div class="col-md-3 pr-1">
										<div class="form-group">
											<label>Questions Added</label> 
											<h5 class="form-control text-success" id="u-total-que"></h5>
										</div>
									</div>
								</div>
								<div class="row">
				              		<div class="col-md-12">
						              	<div class="table-responsive" style="min-height: 300px;max-height: 300px;">
			                  				<table class="table">
			                    			<thead class=" text-primary">
			                      				<th>Question ID</th>
												<th>Question</th>
												<th>Remove</th>
			                    			</thead>
						                    <tbody id="u-group-questions-table-body">
						                    </tbody>
						                  </table>
						                </div>
				              		</div>
								</div>
								</div>
							</div>
						</div>
					<div class="col-md-12">
			           <div class="card">
			              <div class="card-header"></div>
			              <div class="card-body" id="questions-card-body">
						              	<input type="hidden" id="groupID" />
						              	<input type="hidden" id="singleQuestionID" />
						              	<div class="row">
						              		<div class="col-md-8"></div>
							              	<div class="col-md-4">
							              		<div class="update ml-auto mr-auto">
														<input type="button" style="float:right;" class="btn btn-primary btn-round" onclick ="addSelectedQuestionsToGroup();" value="Add Selected Questions">
												</div>
											</div>
										</div>
						              	<div class="table-responsive">
			                  				<table class="table">
			                    				<thead class=" text-primary">
			                    						<th><input type="checkbox" id="selectAll" /></th>
			                      						<th>Question ID</th>
														<th>Question</th>
			                    				</thead>
						                    <tbody id="questions-table-body">
						                    	
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
			<jsp:include page="adminDashboardFooter.jsp" />
  
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
