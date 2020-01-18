/**
 * testDetails.js
 */

$(document).ready(function(){
	getTestInfo();
	getAddedGroupsForSelectedTest();
	getAddedQuestionsForSelectTest();
});
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
				var createdOn = testBo.created_on;
				var updatedOn = testBo.updated_on;
				var createdBy = testBo.created_by;
				var updatedBy = testBo.updated_by;
				$('#testName').text(testName);
				if(startOn != null){
					startOn = startOn.substring(0, startOn.length - 5);
				}
				if(endOn != null){
					endOn = endOn.substring(0, endOn.length - 5);
				}else{
					endOn = 'No Expiration';
				}
				$('#startOn').text(startOn);
				$('#endOn').text(endOn);
				$('#testkey').text(testKey);
				
				$('#accessKey').html('<input type="password" class="access-key-value" disabled id="access-key-'+testID+'" value="'+testAccessKey+'" /><i class="fa fa-eye" onclick="toggleShow(this,'+testID+');"></i>');
				/* $('#accessKey').text(testAccessKey); */
				var testTimeObj = secondsToTime(testTime);
				$('#testTime').text(testTimeObj.h+':'+testTimeObj.m+':'+testTimeObj.s);				
				$('#passingCriteria').text(passingCriteria);
				$('#test-instructions').html(testInstructions);
				$('#createdBy').text(createdBy);
				$('#updatedBy').text(updatedBy);
				$('#createdOn').text(createdOn);
				$('#updatedOn').text(updatedOn);
				$('.test-instructions-loder').hide();
			}
		},
		error : function(itrr) {
			alert("Error occurred while fetching test..!!");
		}
	});
	
}

function getAddedQuestionsForSelectTest(){
	$('#question-list-table-body').html('');
	var testID = $('#testID').val();
	var data = {
			testID : testID
	};
	$.ajax({
		type : "POST",
		url : "getAddedQuestionsForSelectTest",
		dataType: 'json',
		data: JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		success : function(itr) {
			str = '';
			if(itr.questionList !=null && itr.questionList.length > 0){
				if ($.fn.DataTable.isDataTable("#questionListTable")) {
					  $('#questionListTable').DataTable().clear().destroy();
				}
				$('#no-of-questions').html('<a href="#" class="mr-1" data-toggle="modal" data-target="#questionListModal">'+itr.questionList.length+'</a><a href="addedQuestions"> See Questions </a>');
				for(var i = 0 ; i < itr.questionList.length; i++){
					var questionID = itr.questionList[i].question_id;
					var question = itr.questionList[i].question;
					str=str+'<tr>';
					str=str+'<td> <a href="#" onclick="showQuestionDetails('+questionID+');">'+questionID+'<a></td>';
					str=str+'<td>'+question+'</td>';
					str=str+'</tr>';
				}
				$('#question-list-table-body').append(str);
				$("#questionListTable").DataTable();
			}else{
				str += '<tr><td colspan="2"><div class="text-center"> No record found </div></td></tr>';
				$('#question-list-table-body').append(str);
			}
		},
		error : function(itrr) {
			alert("Error occurred while fetching added groups..!!");
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


function secondsToTime(secs)
{
    var hours = Math.floor(secs / (60 * 60));

    var divisor_for_minutes = secs % (60 * 60);
    var minutes = Math.floor(divisor_for_minutes / 60);

    var divisor_for_seconds = divisor_for_minutes % 60;
    var seconds = Math.ceil(divisor_for_seconds);
	if(hours >=0 && hours <=9){
		hours = '0'+hours;
	}
	if(minutes >=0 && minutes <=9){
		minutes = '0'+minutes;
	}
	if(seconds >=0 && seconds <=9){
		seconds = '0'+seconds;
	}
    var obj = {
        "h": hours,
        "m": minutes,
        "s": seconds
    };
    return obj;
}

function getAddedGroupsForSelectedTest(){
	$('#group-list-table-body').html('');
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
				if ($.fn.DataTable.isDataTable("#groupListTable")) {
					  $('#groupListTable').DataTable().clear().destroy();
				}
				$('#total-added-groups').html('<a href="#" data-toggle="modal" data-target="#groupListModal">'+itr.addedGroupsList.length+'</a>');
				for(var i = 0 ; i < itr.addedGroupsList.length; i++){
					var groupID = itr.addedGroupsList[i].group_id;
					var groupName = itr.addedGroupsList[i].group_name;
					str=str+'<tr>';
					str=str+'<td>'+groupID+'</td>';
					str=str+'<td>'+groupName+'</td>';
					str=str+'</tr>';
				}
				$('#group-list-table-body').append(str);
				$("#groupListTable").DataTable();
			}else{
				str += '<tr><td colspan="2"><div class="text-center"> No record found </div></td></tr>';
				$('#group-list-table-body').append(str);
			}
		},
		error : function(itrr) {
			alert("Error occurred while fetching added groups..!!");
		}
	});
}
