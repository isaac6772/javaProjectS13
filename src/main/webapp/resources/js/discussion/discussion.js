'use strict';

$(function() {
	$(document).keydown(function(e) {
		if(e.keyCode==27) $('.discussionModalContainer').hide();
	});
});

function createDiscussion() {
	$('.discussionModalContainer').show();
}

function hideForm() {
	discussionForm.reset();
	$('.discussionModalContainer').hide();5
}