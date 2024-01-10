'use strict';

function search() {
	$('#pag').val(1);
	$('#pageSize').val(10);
	conditionForm.action = "serviceList";
	conditionForm.submit();
}

function deleteService(idx) {
	let ans = confirm("게시물을 삭제하시겠습니까?");
	if(!ans) return false;
	
	location.href = "deleteService?idx=" + idx;
}