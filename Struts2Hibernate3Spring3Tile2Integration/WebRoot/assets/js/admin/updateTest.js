/**
 * updateTest.js
 */



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