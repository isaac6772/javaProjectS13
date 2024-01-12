'use strict';

function imgGroupShow(e) {
	if($(e).parent().next().is(':hidden')) {
		$(e).css('transform','rotateZ(-180deg)');
		$(e).parent().next().slideDown(200);
	}
	else {
		$(e).parent().next().slideUp(200);
		$(e).css('transform','rotateZ(0deg)');
	}
}

function imgGroupCheck(e) {
	if($(e).prop('checked')==true) {
		$(e).parent().next().find('input[type="checkbox"]').prop('checked',true);
	}
	else {
		$(e).parent().next().find('input[type="checkbox"]').prop('checked',false);
	}
}

function moveImg() {
	let images = $('.adList .imgGroup input[type="checkbox"]:checked').next();
	if(images.length==0) {
		alert("이미지 파일이 선택되지 않았습니다.");
		return false;
	}
	
	for(let img of images) {
		let str = "<div class = 'box' onclick = 'selectBox2(this)'><input type='checkbox' class = 'postingAd' /><span>"+img.innerHTML+"</span>";
		str += '<input type = "hidden" name = "fileName" class = "fileName" value = "'+img.innerHTML+'" />';
		str += '<input type = "hidden" name = "serviceIdx" value = "'+$('img').next().val()+'" /></div>';
		$('#adList2').append(str);
	}
}

function checkAll(flag) {
	if(flag==1) {
		if($('#check1').prop('checked')==true) {
			$('#adList1 input[type=checkbox]').prop('checked',true);
		}
		else $('#adList1 input[type=checkbox]').prop('checked',false);
	}
	else {
		if($('#check2').prop('checked')==true) {
			$('#adList2 input[type=checkbox]').prop('checked',true);
		}
		else $('#adList2 input[type=checkbox]').prop('checked',false);
	}
}

function deleteAd() {
	let checkList = $('.availableAd:checked');
	if(checkList.length==0) {
		alert("게시물을 선택해주세요");
		return false;
	}
	let ans = confirm("게시물이 완전히 삭제됩니다.");
	if(!ans) return false;
	
	let idxList = '';
	for(let service of checkList) {
		idxList += $(service).parent().find('input[type=hidden]').val() + ",";
	}
	idxList = idxList.substring(0,idxList.length-1);
	
	location.href = "adServiceDelete?idx=" + idxList;
}

function saveAd() {
	adSubmitForm.submit();
}

function deletePosting() {
	$('#adList2 input[type=checkbox]:checked').parent().remove();
}

function selectBox(e) {
	$('#adList1 div.imgName.selected').removeClass('selected');
	$(e).addClass('selected');
	$('#frame1').html('<img src='+contextPath+'/service/'+$(e).find('.name').html()+'/>');
}

function selectBox2(e) {
	$('#adList2 .box.selected').removeClass('selected');
	$(e).addClass('selected');
	$('#frame2').html('<img src='+contextPath+'/service/'+$(e).find('.fileName').val()+'/>');
}

function moveDown() {
	$('#adList2 .box.selected').next().after($('#adList2 .box.selected'));
}

function moveUp() {
	$('#adList2 .box.selected').after($('#adList2 .box.selected').prev());
}

$(function() {
	$('#adList2 .box:eq(0)').click();
});
