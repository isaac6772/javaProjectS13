'use strict';
let colors = ['#ec4d4d','#f99236','#7ddc02','#23c226','#23c28b','#23bdc2','#2374c2','#2345c2','#8623c2','#e70086'];

$(function() {
	// 비동기적으로 뉴스데이터 가져오기
	$('.newsLoaderLayer').load(contextPath + "/news/newsList?keyword=" + keyword + " .newsList",function() {
		$('.mainLoading').hide();
		$('.newsLoaderLayer').show();
		$('.newsMore').show();
	});
	
	// 키워드 색깔 랜덤 지정
	let items = $('.keyword');
	
	for(let item of items) {
		let random = Math.floor(Math.random()*10);
		$(item).css('background-color',colors[random]);
	}
	
	// 뉴스 모달 닫기
	$('.newsModalContainer').click(function(e) {
		if(e.target == document.getElementById("newsModal")) $('.newsModalContainer').hide();
	});
	
	// 뉴스 모달 닫기
	$(document).keydown(function(e) {
		if(e.keyCode=='27') {
			$('.newsModalContainer').hide();
		}
	})
});

function newsModalShow(e) {
	let content = $(e).parent().find('.articleContent').html();
	$('#newsModalContent').html(content);
	$('.newsModalContainer').show();
}
