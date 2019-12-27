var isAlreadyChecked = false;
var isSelectedAllCheckBox = false;
$(document).ready(function () {
	 $('#availableGroups').multiselect({
         includeSelectAllOption: true,
         buttonWidth: 250,
         enableFiltering: true     
     });
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
	
	$('#summernote').summernote({
		height: 300,
		popover: {
	         image: [],
	         link: [],
	         air: []
	       }
	});
	
//	getAllTests();
	applyTestsFilter('ON_LOAD');
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
	var startOn = '';
	if($('#startOn').val() != ''){
		startOn = $('#startOn').val()+':00';
	}
	var endOn = '';
	if($('#endOn').val() != ''){
		endOn = $('#endOn').val()+':00';
	}
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
			testkey: testkey,
			accessKey: accessKey,
			groupIDs: $('#availableGroups').val(),
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
			if(itr.res != null && (itr.errorMsg == null || itr.errorMsg == '')){
				var status = itr.res.status;
				if(status == 200){
					alert(itr.res.message);
//					getAllTests();
					applyTestsFilter('ON_LOAD');
					$('.add-one-more').remove();
					$('#last-step').append('<a href="testsPage" class="btn btn-primary pull-right add-one-more">Add One More</a>');
				}else if(status == 403){
					alert(itr.res.message);
				}
			}else{
				alert(itr.errorMsg);
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

function applyTestsFilter(flag){
	$('#tests-table-body').html('');
	$('.tests-table-loader').show();
	var testName = $('#byTestName').val();
	var testId = $('#byTestId').val();
	var startDate = '';
	var endDate = ''; 
	var testKey = $('#byTestKey').val();
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
			testName : testName.trim(),
			testId : +testId,
			createdBy : createdBy,
			testKey : testKey
	};
	
	$.ajax({
		type : "POST",
		url : "getTestReport",
		data: JSON.stringify(data),
		dataType: 'json',
		contentType:"application/json;charset=utf-8",
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
				$('.tests-table-loader').hide();

			}else{
				str += '<tr><td colspan="10"><div class="text-center"> No record found </div></td></tr>';
				$('#tests-table-body').append(str);
				$('.tests-table-loader').hide();
			}
		},
		error : function(itr) {
			alert("Error while processing the request....!!");
		}
	});
	$('#testFilterModal').modal('hide');
}