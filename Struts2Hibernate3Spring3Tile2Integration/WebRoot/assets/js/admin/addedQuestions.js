/**
 * addedQuestions.js
 */

$(document).ready(function(){
	$('.back-btn').attr('href','testDetails?testID='+$('#testID').val());
	getAddedQuestionsForSelectTest();
});
function getAddedQuestionsForSelectTest(){
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
				for(var i = 0 ; i < itr.questionList.length; i++){
					var questionID = itr.questionList[i].question_id;
					getQuestionDetails(questionID);
				}
				
			}
		},
		error : function(itrr) {
			alert("Error occurred while fetching added questions..!!");
		}
	});
}

function getQuestionDetails(queID){
	var str ='';
	var correctAns = '';
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
			if(itr.questionDetail != null && itr.questionDetail != undefined){
				str += '<div class="que-bank-row" style="padding: 1rem;"><div class="row mt-4"><div class="col-md-12 questionArea">'
					+'<h5 class="questionName">'+itr.questionDetail.question+'</h5></div></div>';
				str += '<div class="row"><div class="col-md-12 optionsArea">';
				var cnt = 65;
				for( var i = 0 ; i < itr.questionDetail.options.length; i++){
					if(itr.questionDetail.answer == itr.questionDetail.options[i]){
						ans = cnt;
						correctAns = '<i class="fa fa-check-circle ml-2" style="font-size:20px;color:#198764;"></i>';
						/* str += '<li>'+itr.questionDetail.options[i]+'<b class="ml-1" style="color:#198764;">CORRECT</b></li>';	 */
						str += '<p> &#'+cnt+'; . '+itr.questionDetail.options[i]+'  '+correctAns+'</p>';
					}else{
						str += '<p> &#'+cnt+'; . '+itr.questionDetail.options[i]+'</p>';	
					}
					cnt++;
				}
				str += '</div></div>';
				str += '<div class="row mb-2 "><div class="col-md-12 answerArea"><b class="answer">Answer: &#'+ans+';</b></div></div></div><hr>';
				 $('.question-ans-bank-area').append(str);

			}else{
				if(itr.re.status == 403 && itr.re != null ){
					alert(itr.re);
				}
				
			}
		},
		error : function(itrr) {
			alert("Error occurred while getting question details..!!");
		}
	});
}

function exportToPDF() {
    var pdf = new jsPDF('p', 'pt', 'letter');
    // source can be HTML-formatted string, or a reference
    // to an actual DOM element from which the text will be scraped.
    source = $('.question-ans-bank-area')[0];

    // we support special element handlers. Register them with jQuery-style
    // ID selector for either ID or node name. ("#iAmID", "div", "span" etc.)
    // There is no support for any other type of selectors
    // (class, of compound) at this time.
    specialElementHandlers = {
        // element with id of "bypass" - jQuery style selector
        '#editor': function (element, renderer) {
            // true = "handled elsewhere, bypass text extraction"
            return true
        }
    };
    margins = {
        top: 80,
        bottom: 60,
        left: 40,
        width: 522
    };
    // all coords and widths are in jsPDF instance's declared units
    // 'inches' in this case
    pdf.fromHTML(
        source, // HTML string or DOM elem ref.
        margins.left, // x coord
        margins.top, { // y coord
            'width': margins.width, // max width of content on PDF
            'elementHandlers': specialElementHandlers
        },

        function (dispose) {
            // dispose: object with X, Y of the last line add to the PDF
            //          this allow the insertion of new lines after html
            pdf.save('question-ans-bank.pdf');
        }, margins
    );

}
