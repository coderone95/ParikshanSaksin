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
.table>thead>tr>th, .table>tbody>tr>th, .table>tfoot>tr>th, .table>thead>tr>td, .table>tbody>tr>td, .table>tfoot>tr>td {
	padding: 0 !important;
	vertical-align: unset !important;
}
.table td, .table th {
	padding: 0 !important;
}
.delete , .edit{
	padding: 0.7rem;
    cursor: pointer;
}

</style>
<script>
	var isAlreadyChecked = false;
	var isSelectedAllCheckBox = false;
	$(document).ready(function(){
		getAllGroupsInfo();
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
		$('#createGroupForm').on('submit', function(){
			var formInput=$(this).serialize();    
			$.getJSON('createGroup.action', formInput,function(data) {
				if(data.errorMessagesList != null && data.errorMessagesList.length > 0){
					alert(data.errorMessagesList[0].errorMsg);
				}else{
					$('#groupID').val(data.groupID);
					getAllGroupsInfo();
					alert('Group create successfully');
					getAllQuestions();
					$('#addQuestionToGroupModal').modal('show');
				}
			});  
			return false; 	
		});
	});

	function getAllGroupsInfo(){
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
						var createdBy = itr.groupList[i].created_by;
						var createdOn = formatDate(new Date(itr.groupList[i].created_on));
						var updatedBy = itr.groupList[i].updated_by;
						var updatedOn = formatDate(new Date(itr.groupList[i].updated_on));
						if(createdBy == null || createdBy == ''){
							createdBy = '';
						}
						if(updatedBy == null || updatedBy == ''){
							updatedBy = '';
						}
						str += '<tr id="group-'+groupID+'"><th scope="row"><a href="#" onclick="viewGroupDetails('+groupID+',\''+groupName+'\');">' + groupID + '</a></th><td>'
								+ groupName + '</td><td>' + createdBy + '</td><td>'
								+ updatedBy + '</td><td>' + createdOn + '</td><td>'
								+ updatedOn + '</td>'
								+'<td><i class="fa fa-trash delete text-danger" onclick="deleteGroup('+groupID+');"></i>'
								+'<i class="fa fa-pencil edit text-primary" onclick="updateGroup('+groupID+',\''+groupName+'\');"></i></td></tr>';
 
					}
					/* <button class="btn btn-outline-primary" onclick="updateGroupDetails('+groupID+',\''+groupName+'\');"> */
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
	
	function updateGroup(groupID, groupName){
		localStorage.removeItem("selectedGroupName");
		localStorage.setItem("selectedGroupName",groupName);
		window.location.href = "updateGroupPage.action?selectedGId="+groupID;
	}
	function viewGroupDetails(selectedGroupID,groupName){
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
				$('#group-name').text(groupName);
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
	function deleteGroup(groupID){
		$('#deleteModal').modal('show');
		$('#deleteBtn').removeAttr('onclick');
		$('#deleteBtn').attr('onclick','deleteSelectedGroup('+groupID+');');
	}
	function deleteSelectedGroup(selectedGroupID){
		var data = {
				selectedGroupID : selectedGroupID
		};
		$.ajax({
			type : "POST",
			url : "deleteSelectedGroup",
			dataType: 'json',
			data: JSON.stringify(data),
			contentType:"application/json;charset=utf-8",
			success : function(itr) {
				alert("Group deleted!!");
				$('#deleteModal').modal('hide');
				$('#group-'+selectedGroupID).fadeTo("slow",0.7, function(){
		            $(this).remove();
		        })
			},
			error : function(itrr) {
				alert("Error occurred while getting question details..!!");
			}
		});
	}
	
	function addQuestions(groupID){
		$('#groupID').val(groupID);
		getAllQuestions();
		$('#addQuestionToGroupModal').modal('show');
		
	}
	
	function getAllQuestions(){
		$('#questions-table-body').html('');
		$.ajax({
			type : "POST",
			url : "getAllQuestions",
			success : function(itr) {
				var str = '';
				if (itr.questionInfo != null && itr.questionInfo.length > 0) {
					for (var i = 0; i < itr.questionInfo.length; i++) {
						var queID = itr.questionInfo[i].question_id;
						var question = itr.questionInfo[i].question;
						
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
			error : function(itrr) {
				alert("Error occurred while getting all questions...!!");
			}
		});
	}
	function addThis(queID){
		$('#singleQuestionID').val(queID);
	}
	function addSelectedQuestionsToGroup(){
		var selectedGroupID = $('#groupID').val();
		var selectedQuestionIDs = [];
		
		/* if(isSelectedAllCheckBox){
			$('.selectQuestionCheckBox').each(function(){
				selectedQuestionIDs.push($(this).val());
			});	
		} */
		$('.selectQuestionCheckBox').each(function(){
			if($(this).prop('checked') == true){
				selectedQuestionIDs.push($(this).val());	
			}
		});	
		
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
	
</script>

</head>

<body class="">
	<input type="hidden" id="pageId" value="groups" />
	<input type="hidden" id="page" value="Groups" />
	<div class="wrapper ">
		<jsp:include page="adminSideBar.jsp"></jsp:include>
		<div class="main-panel">
			<jsp:include page="adminDashboardTopNav.jsp"></jsp:include>
			<div class="content">
				<div class="row">
					<div class="col-md-12">
							<div class="row">
								<div class="col-md-6">
							         <div class="card demo-icons">
									<div class="card-header">
										<h4 id="user-form-card-heading">Create Group</h4>
									</div>
									<div class="card-body" id="">
										<form action="" method="post" id="createGroupForm">
												<div class="row">
													<div class="col-md-12 pr-1">
														<div class="row">
															<div class="col-md-8 pr-1">
																<div class="form-group">
																	<!-- <label>Group Name</label>  -->
																	<input type="text" class="form-control" required name="groupbean.group_name" id="groupName"/>
																</div>
															</div>
														<div class="col-md-4 pr-1">
															<div class="form-group">
																<input type="submit" style="margin: 0;" id="addGroupOrSet" class="btn btn-primary  btn-round" value="Add Group">
															</div>
														</div>
													</div>
												</div>
												</div>
										</form>
									</div>
									</div>
							</div>
			       		</div>
			       	</div>
					<div class="col-md-12">
			           <div class="card">
			              <div class="card-header"></div>
			              <div class="card-body" id="group-card-body">
			              	
			              	<div class="table-responsive">
                  				<table class="table">
                    				<thead class=" text-primary">
                      						<th>Group ID</th>
											<th>Group Name</th>
											<th>Created By</th>
											<th>Updated By</th>
											<th>Created On</th>
											<th>Updated On</th>
											<th>Action</th>
                    				</thead>
			                    <tbody id="groups-table-body">
			                    
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
	 <!-- Add Questions to Group Modal -->
  <div class="modal fade" id="addQuestionToGroupModal" role="dialog">
    <div class="modal-dialog" style="min-width: 1000px;max-width: 1000px;">
    
      <!-- Modal content-->
      <div class="modal-content">
       <div class="modal-header">
       		<h5 class="modal-title">Add Questions in Group</h5>
        	<button type="button" style="font-size: 2.5rem;" class="close" data-dismiss="modal">&times;</button>
      </div>
        <div class="modal-body">
				<div class="row">
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
  </div>
  <!-- View Group Details Modal Popup -->
  <div class="modal fade" id="viewGroupDetailsModal" role="dialog">
    <div class="modal-dialog" style="min-width: 900px;max-width: 900px;">
    
      <!-- Modal content-->
      <div class="modal-content">
       <div class="modal-header">
       		<h5 class="modal-title">Group Details</h5>
        	<button type="button" style="font-size: 2.5rem;" class="close" data-dismiss="modal">&times;</button>
      </div>
        <div class="modal-body">
				<div class="row">
					<div class="col-md-12">
			           <div class="card">
			              <div class="card-header"></div>
			              <div class="card-body" id="questions-card-body">
			              	<input type="hidden" id="groupID" />
			              	<input type="hidden" id="singleQuestionID" />
			              	<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label>Group Name</label> 
										<h5 class="form-control" id="group-name"></h5>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label>Number of Questions</label>
										<h5 class="form-control text-primary" id="total-que"></h5> 
									</div>
			              		</div>
							</div>
							<div class="row">
			              		<div class="col-md-12">
					              	<div class="table-responsive">
		                  				<table class="table">
		                    			<thead class=" text-primary">
		                      				<th>Question ID</th>
											<th>Question</th>
		                    			</thead>
					                    <tbody id="group-questions-table-body">
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
    </div>
  </div>
  <!-- show question details -->
  <div class="modal fade" id="showQuestionDetailsModal" role="dialog">
    <div class="modal-dialog" style="min-width: 900px;max-width: 900px;">
    
      <!-- Modal content-->
      <div class="modal-content">
       <div class="modal-header">
       		<b style="font-size:1.5rem;" class="modal-title">Question</b>
        	<button type="button" style="font-size: 2.5rem;" class="close" data-dismiss="modal">&times;</button>
      </div>
        <div class="modal-body">
				<div class="row">
					<div class="col-md-12">
						<div class="card demo-icons">
							<div class="card-header">
								
							</div>
							<div class="card-body" id="question-options-card-body">
							<div class="row">
								<div class="col-md-12" id="questionArea">
									<h6 id="questionName"></h6>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12" id="optionsArea">
									<ol type="A"  id="optionList">
										
									</ol>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12" id="answerArea">
									<hr>
									<b id="answer"></b>
								</div>
							</div>	
							</div>
						</div>
					</div>
				</div>
        </div>
      </div>
    </div>
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
		        
<!-- 		        Modal footer -->
<!-- 		        <div class="modal-footer"> -->
<!-- 		          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button> -->
<!-- 		        </div> -->
		        
		      </div>
		    </div>
		  </div> 
	<div class="modal fade" id="updateGroupModal" role="dialog">
    <div class="modal-dialog" style="min-width: 900px;max-width: 900px;">
    
      <!-- Modal content-->
      <div class="modal-content">
       <div class="modal-header">
       		<h5 class="modal-title">Update Group</h5>
        	<button type="button" style="font-size: 2.5rem;" class="close" data-dismiss="modal">&times;</button>
      </div>
        <div class="modal-body">
				<div class="row">
					<div class="col-md-12">
						<div class="card demo-icons">
							<div class="card-header">
							</div>
							<div class="card-body">
								<input type="hidden" id="selectedGroupID">
								<div class="row">
									<div class="col-md-6 pr-1">
										<div class="form-group">
											<label>Group</label> 
											<input type="text" class="form-control" name="u-group-name" id="u-group-name" />
										</div>
									</div>
									<div class="col-md-6 pr-1">
										<div class="form-group">
											<label></label> 
											<button id="u-total-que" class="btn btn-primary btn-round">Add More Questions</button>
										</div>
									</div>
									<div class="col-md-6 pr-1"></div>
								</div>
								<div class="row">
				              		<div class="col-md-12">
						              	<div class="table-responsive">
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
								<div class="row">
										<div class="update ml-auto mr-auto">
											<input type="button" id="updateGroupBtn" class="btn btn-primary btn-round" onclick="updateGroupInfo();" value="Update Group">
										</div>
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
	<script src="./assets/js/paper-dashboard.min.js?v=2.0.0"
		type="text/javascript"></script>
	<!-- Paper Dashboard DEMO methods, don't include it in your project! -->
	<script src="./assets/demo/demo.js"></script>
	

</body>

</html>
