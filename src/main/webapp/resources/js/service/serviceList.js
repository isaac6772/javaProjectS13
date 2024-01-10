'use strict';

function pageMove(pag) {
	$('#pag').val(pag);
	$('#pageSize').val($('#pageSizeSelect').val());
	conditionForm.submit();
}

function pageSizeChange() {
	$('#pag').val(1);
	$('#pageSize').val($('#pageSizeSelect').val());
	conditionForm.submit();
}

function goContent(idx) {
	location.href = "serviceContent?idx=" + idx;
}