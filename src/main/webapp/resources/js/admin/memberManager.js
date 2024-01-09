'use strict'

function memberSearch() {
	$('#pag').val(1);
	$('#pageSize').val($('#pageSizeSelect').val());
	searchForm.action = contextPath + "/admin/memberManager";
	searchForm.submit();
}

function pageMove(pag) {
	$('#pag').val(pag);
	$('#pageSize').val($('#pageSizeSelect').val());
	searchForm.action = contextPath + "/admin/memberManager";
	searchForm.submit();
}

function memberUpdate(e,mid,nickName,name,email,level,point) {
	let option = '';
	if(level==1) option = '<option selected>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option value ="0">탈퇴</option></select>';
	else if(level==2) option = '<option>1</option><option selected>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option value ="0">탈퇴</option></select>'
	else if(level==3) option = '<option>1</option><option>2</option><option selected>3</option><option>4</option><option>5</option><option>6</option><option value ="0">탈퇴</option></select>'
	else if(level==4) option = '<option>1</option><option>2</option><option>3</option><option selected>4</option><option>5</option><option>6</option><option value ="0">탈퇴</option></select>'
	else if(level==5) option = '<option>1</option><option>2</option><option>3</option><option>4</option><option selected>5</option><option>6</option><option value ="0">탈퇴</option></select>'
	else if(level==6) option = '<option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option selected>6</option><option value ="0">탈퇴</option></select>'
	else if(level==0) option = '<option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option value ="0" selected>탈퇴</option></select>'
	
	$(e).parent().parent().find('.col3').html('<input type = "text" value = "'+mid+'" name = "mid" class = "update" />');
	$(e).parent().parent().find('.col4').html('<input type = "text" value = "'+nickName+'" name = "nickName" class = "update" />');
	$(e).parent().parent().find('.col5').html('<input type = "text" value = "'+name+'" name = "name" class = "update" />');
	$(e).parent().parent().find('.col6').html('<input type = "text" value = "'+email+'" name = "email" class = "update" />');
	$(e).parent().parent().find('.col7').html('<select name = "level" class = "update">' + option);
	$(e).parent().parent().find('.col8').html('<input type = "text" value = "'+point+'" name = "point" class = "update" />');
	
	$(e).parent().find('.btn').css('display','inline-block');
}

function cancelUpdate(e,mid,nickName,name,email,level,point) {
	$(e).parent().parent().find('.col3').html('<span>'+mid+'</span>');
	$(e).parent().parent().find('.col4').html('<span>'+nickName+'</span>');
	$(e).parent().parent().find('.col5').html('<span>'+name+'</span>');
	$(e).parent().parent().find('.col6').html('<span>'+email+'</span>');
	$(e).parent().parent().find('.col7').html('<span>'+level+'</span>');
	$(e).parent().parent().find('.col8').html('<span>'+point+'</span>');
	
	$(e).parent().find('.btn').hide();
}

function saveUpdate(idx) {
	let myForm = document.getElementById('memberListForm' + idx);
	myForm.submit();
}

function checkAll() {
	if(sw==0) {
		$('.memberList .col1 input[type=checkbox]').prop('checked',true);
		sw = 1;		
	}
	else {
		$('.memberList .col1 input[type=checkbox]').prop('checked',false);
		sw = 0;
	}
}

function deleteSelectedMember() {
	let memberIdxArray = '';
	let cnt = $('.memberList').length;

	if($('.memberList .col1 input[type=checkbox]:checked').length==0) {
		alert("회원을 선택해주세요");
		return false;
	}
	
	let ans = confirm("DB에서 복구할 수 없습니다. 정말 삭제할까요?");
	if(!ans) return false;
	
	for(let i=0; i<cnt; i++) {
		if($('.memberList:eq('+i+') .col1 input[type=checkbox]').is(':checked')) {
			memberIdxArray += $('.memberList:eq('+i+') .hiddenIdx').val() + ',';
		}
	}
	memberIdxArray = memberIdxArray.substring(0,memberIdxArray.length-1);
	
	$('#deleteMemberIdx').val(memberIdxArray);
	memberDeleteForm.action = "selectedMemberDelete";
	memberDeleteForm.submit();
}

function memberDelete(idx) {
	let ans = confirm("영구적으로 삭제합니다.");
	if(!ans) return false;
	
	$('#deleteMemberIdx').val(idx);
	memberDeleteForm.action = "selectedMemberDelete";
	memberDeleteForm.submit();
}