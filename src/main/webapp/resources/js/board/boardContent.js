$(function() {
	$('.replContent textarea').on('keyup',function() {
		this.style.height = 'auto';
		this.style.height = this.scrollHeight + 'px';
	});
	
	for(let e of $('.replyGroup')) {
		let cnt = $(e).find('.reReply').length;
		if(cnt != 0) $(e).find('.reReplyCnt').html(cnt);
	}
});

function reReplyFormShow(e) {
	if($(e).closest('.replyGroup').find('.reReplyForm').is(':hidden')) {
		$(e).closest('.replyGroup').find('.reReplyForm').show();
		$(e).closest('.replyGroup').find('.reReplyForm textarea').focus();
	}
	else $(e).closest('.replyGroup').find('.reReplyForm').hide();
}

function optionFormShow(e) {
	if($(e).parent().find('.optionForm').is(':hidden')) $(e).parent().find('.optionForm').show();
	else $(e).parent().find('.optionForm').hide();
}