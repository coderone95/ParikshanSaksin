/**
 * testInstructionPage.js 
 */

$(document).ready(function(){
		getTestInstructions();
		$('#startTest-btn').click(function(){
			var testID = $('#testID').val();
			var form = document.createElement('form');
			form.setAttribute('action','saveAttendedTestDetails');
			form.setAttribute('method','post');
			var testIDInput = document.createElement('input');
			testIDInput.setAttribute('type','text');
			testIDInput.setAttribute('value',testID);
			testIDInput.setAttribute('name','testID');
			var startTimeInput = document.createElement('input');
			startTimeInput.setAttribute('type','text');
			startTimeInput.setAttribute('value',convertToLocalStringTime(new Date()));
			startTimeInput.setAttribute('name','starttime');
			form.appendChild(testIDInput);
			form.appendChild(startTimeInput);
			document.body.appendChild(form);
			form.submit();
		});
		if($('#hasExamStarted').val() == 'YES'){
			getGroupsInfoAndNumberOfQuestionCount();
		}
	});

function convertToLocalStringTime(today){
	var day = today.getDate() + "";
	var month = (today.getMonth() + 1) + "";
	var year = today.getFullYear() + "";
	var hour = today.getHours() + "";
	var minutes = today.getMinutes() + "";
	var seconds = today.getSeconds() + "";

	day = checkZero(day);
	month = checkZero(month);
	year = checkZero(year);
	hour = checkZero(hour);
	mintues = checkZero(minutes);
	seconds = checkZero(seconds);
	
	console.log(day + "/" + month + "/" + year + " " + hour + ":" + minutes + ":" + seconds);
	return year + "-" + month + "-" + day + " " + hour + ":" + minutes + ":" + seconds;
}

function checkZero(data){
	  if(data.length == 1){
	    data = "0" + data;
	  }
	  return data;
}

function getGroupsInfoAndNumberOfQuestionCount(){
	$('.exam-set-dropdown-ul').html('');
	var testID = $('#testID').val();
	var data = {
			testID : testID	
	};
	$.ajax({
		type : "POST",
		url : "getGroupsInfoAndNumberOfQuestionCount",
		dataType: 'json',
		data: JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		success : function(itr) {
			var str = '';
			if(itr.GROUPS_INFO_AND_NUMBER_OF_QUE_COUNT != null && itr.GROUPS_INFO_AND_NUMBER_OF_QUE_COUNT.length >0){
				var sr = 1;
				let groupInfoAndCountList = itr.GROUPS_INFO_AND_NUMBER_OF_QUE_COUNT;
				for(var i = 0 ; i < groupInfoAndCountList.length; i++){
					var groupID = groupInfoAndCountList[i].group_id;
					var groupName = groupInfoAndCountList[i].group_name;
					var count = groupInfoAndCountList[i].numberOfQuestionsCount;
					str += '<li class="lis"><a href="#"><span class="exam-set-name" id="exam-set-id-'+groupID+'" value="'+groupID+'">'+groupName+'</span></a></li>';
				}
				$('.exam-set-dropdown-ul').append(str);
			}
		},
		error : function(itrr) {
			alert("Error occurred while fetching the data..!!");
		}
	});
}

	
	function getTestInstructions(){
		setTimeout(function(){$('.instrustions-loader').addClass('display-none')},1000);
		$('.test-instructions').html('');
		var testID = $('#testID').val();
		var data = {
				testID : testID
		};
		$.ajax({
			type : "POST",
			url : "getTestInstructions",
			dataType: 'json',
			data: JSON.stringify(data),
			contentType:"application/json;charset=utf-8",
			success : function(itr) {
				$('.test-instructions').append(itr.testAuthBean.test_instructions);
			},
			error : function(itrr) {
				alert("Error occurred while fetching the test instructions..!!");
			}
		});
	}
	function clearSessionValues(){
		sessionStorage.clear();
			// similar behavior as clicking on a link
		window.location.href = "logout";
	}