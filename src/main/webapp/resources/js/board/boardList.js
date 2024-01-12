function pageScopeChange(scope) {
	$('#scope').val(scope);
	
	$('#pag').val(1);
	$('#searchType').val('all');
	$('#searchString').val('');
	
	pagingForm.submit();
}