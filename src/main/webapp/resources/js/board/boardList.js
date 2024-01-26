function pageScopeChange(scope) {
	$('#scope').val(scope);
	
	$('#pag').val(1);
	$('#searchType').val('all');
	$('#searchString').val('');
	if(scope=='공지') $('#part').val('전체');
		
	pagingForm.submit();
}

function pageMove(pag) {
	$('#pag').val(pag);
	
	pagingForm.submit();
}

function pageSizeChange(e) {
	$('#pageSize').val($(e).val());
	
	$('#pag').val(1);
	
	pagingForm.submit();
}

function partChange(part) {
	$('#part').val(part);
	
	$('#pag').val(1);
	$('#searchType').val('all');
	$('#searchString').val('');
	
	pagingForm.submit();
}

function boardContent(idx) {
	$('#idx').val(idx);
	pagingForm.action = "boardContent";
	pagingForm.submit();
}

function settingFormShow() {
	if($('.settingForm').is(':hidden')) $('.settingForm').show();
	else $('.settingForm').hide();
}

function memberOptionModalShow(e) {
	if($(e).parent().find('.memberOptionModal').is(':hidden')) {
		$('.memberOptionModal').hide();
		$(e).parent().find('.memberOptionModal').show();	
	}
	else $(e).parent().find('.memberOptionModal').hide();
}

function requestFriend(idx,e) {
	$(e).parent().hide();
	$.ajax({
		url : contextPath + "/member/requestFriend",
		data : {idx : idx},
		type : "post",
		success : function(res) {
			if(res==1) {
				alert("친구요청되었습니다. 상대방이 수락하면 친구가 될 수 있습니다.");
			}
			else if(res==0) {
				alert("이미 요청 처리중입니다.");
			}
			else if(res==-1) {
				alert("이미 친구 상태입니다.");
			}
		},
		error : function() {
			alert("전송오류");
		}
	});
}