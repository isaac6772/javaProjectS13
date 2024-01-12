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