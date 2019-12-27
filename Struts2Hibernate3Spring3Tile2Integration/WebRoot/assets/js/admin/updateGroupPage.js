var isAlreadyChecked = false;
	var isSelectedAllCheckBox = false;
	$(document).ready(function(){
		var selectedID = $('#selectedId').val();
		getAddedQuestionsForSelectedGroup(selectedID);
		getAvailableQuestionsForSelectedGroup(selectedID);
		$('.groups-update-loader-row-1').show();
		$('.groups-update-loader-row-2').show();
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
					$('.groups-update-loader-row-2').hide();

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
					$('.groups-update-loader-row-1').hide();
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
		
			$('.selectQuestionCheckBox').each(function(){
				if($(this).prop('checked')){
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
	