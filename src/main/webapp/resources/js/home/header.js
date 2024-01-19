'use strict';
$(function() {
	$('#search').keydown(function(e) {
		let keyword = $('#search').val().trim();
		if(e.keyCode==13) location.href = contextPath + '/news/news?flag=true&keyword=' + keyword;
	});
})