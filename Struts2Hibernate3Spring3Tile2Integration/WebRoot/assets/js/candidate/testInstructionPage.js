/**
 * testInstructionPage.js 
 */

$(document).ready(function(){
		getTestInstructions();	
	});
	
	function startTest(){
		sessionStorage.removeItem("EVGivingTestForID");
		sessionStorage.setItem('EVGivingTestForID',$('#testID').val());
		sessionStorage.removeItem('exam-start-time');
		sessionStorage.setItem('exam-start-time',new Date());
		window.location.href = 'startTest.action';
	}
	
	function getTestInstructions(){
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