'use strict'

function reportSearch() {
	$('#pag').val(1);
	$('#pageSize').val($('#pageSizeSelect').val());
	searchForm.action = contextPath + "/admin/reportManager";
	searchForm.submit();
}

function pageMove(pag) {
	$('#pag').val(pag);
	$('#pageSize').val($('#pageSizeSelect').val());
	searchForm.action = contextPath + "/admin/reportManager";
	searchForm.submit();
}

function checkAll() {
	if(sw==0) {
		$('.reportList .col1 input[type=checkbox]').prop('checked',true);
		sw = 1;		
	}
	else {
		$('.reportList .col1 input[type=checkbox]').prop('checked',false);
		sw = 0;
	}
}

function deleteSelectedReport() {
	let reportIdxArray = '';
	let cnt = $('.reportList').length;

	if($('.reportList .col1 input[type=checkbox]:checked').length==0) {
		alert("글을 선택해주세요");
		return false;
	}
	
	let ans = confirm("DB에서 복구할 수 없습니다. 정말 삭제할까요?");
	if(!ans) return false;
	
	for(let i=0; i<cnt; i++) {
		if($('.reportList:eq('+i+') .col1 input[type=checkbox]').is(':checked')) {
			reportIdxArray += $('.reportList:eq('+i+') .hiddenIdx').val() + ',';
		}
	}
	reportIdxArray = reportIdxArray.substring(0,reportIdxArray.length-1);
	
	$('#deleteReportIdx').val(reportIdxArray);
	reportDeleteForm.action = "selectedReportDelete";
	reportDeleteForm.submit();
}

function goContent(reportType, reportIdx) {
	if(reportType == "boardReply") {
		window.top.location.href = contextPath + "/board/findContentByReply?replyIdx=" + reportIdx;
	}
	else if(reportType == 'board') {
		window.top.location.href = contextPath + "/board/boardContent?idx=" + reportIdx;
	}
}

function deleteContent(reportType, reportIdx, reporter, memberIdx, idx) {
	window.top.location.href = "reportContentDelete?reportType=" + reportType + "&reportIdx=" + reportIdx + "&reporter=" + reporter + "&memberIdx=" + memberIdx + "&idx=" + idx;
}