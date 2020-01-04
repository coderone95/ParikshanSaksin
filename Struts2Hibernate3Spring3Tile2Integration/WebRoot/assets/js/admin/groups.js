var isAlreadyChecked = false;
	var isSelectedAllCheckBox = false;
	$(document).ready(function(){
		//getAllGroupsInfo();
		applyGroupsFilter('ON_LOAD');
		$('.datepicker').datepicker({
	    	format: "yyyy-mm-dd",
	    	todayHighlight : true,
	    	language:'en',
	    	/* todayBtn: true, */
	    	clearBtn : true,
	    	autoclose : true
	    });
	    $('.datepicker').datepicker('setDate', new Date());
	    
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
					applyGroupsFilter('ON_LOAD');
					alert('Group create successfully');
					getAllQuestions();
					$('#addQuestionToGroupModal').modal('show');
				}
			});  
			return false; 	
		});
	});

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
		        applyGroupsFilter('ON_LOAD');
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
	
	function applyGroupsFilter(flag){
		$('.groups-table-loader').show();
		$('#groups-table-body').html('');
		var groupName = $('#byGroupName').val();
		var groupId = $('#byGroupId').val();
		var startDate = '';
		var endDate = ''; 
		if(flag == 'ON_LOAD'){
			startDate = '';
			endDate = ''; 
		}else{
			if($('#startDate').val() != ''){
				startDate = $('#startDate').val() + " 00:00:00";
			}
			if($('#endDate').val() != ''){
				endDate = $('#endDate').val() + " 23:59:00";
			}
		}
		
		var createdBy = $('#createdBy').val();
		
		var data = {
				startDate : startDate,
				endDate : endDate,
				groupName : groupName,
				groupId : +groupId,
				createdBy : createdBy
		};
		
		$.ajax({
			type : "POST",
			url : "getGroupReport",
			data: JSON.stringify(data),
			dataType: 'json',
			contentType:"application/json;charset=utf-8",
			success : function(itr) {
				var str = '';
				if (itr.groupList != null && itr.groupList.length > 0) {
					for (var i = 0; i < itr.groupList.length; i++) {
						var groupID = itr.groupList[i].group_id;
						var groupName = itr.groupList[i].group_name;
						var createdBy = itr.groupList[i].created_by;
						var createdOn = formatMyDate(new Date(itr.groupList[i].created_on));
						var updatedBy = itr.groupList[i].updated_by;
						var updatedOn = formatMyDate(new Date(itr.groupList[i].updated_on));
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
					$('#groups-table-body').append(str);
					$('.groups-table-loader').hide();

				}else{
					str += '<tr><td colspan="7"><div class="text-center"> No record found </div></td></tr>';
					$('#groups-table-body').append(str);
					$('.groups-table-loader').hide();
				}
			},
			error : function(itr) {
				alert("Error while processing the request....!!");
			}
		});
		$('#groupFilterModal').modal('hide');
	}
	

	function formatMyDate(date) {
		  var day = date.getDate();
		  var monthIndex = date.getMonth();
		  monthIndex = monthIndex +1;
		  var year = date.getFullYear();
		  return day+'-'+monthIndex+'-'+year;
		}