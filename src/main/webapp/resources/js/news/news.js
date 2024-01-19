'use strict';
let colors = ['#ec4d4d','#f99236','#7ddc02','#23c226','#23c28b','#23bdc2','#2374c2','#2345c2','#8623c2','#e70086'];

$(function() {
	// 비동기적으로 뉴스데이터 가져오기
	$('.newsLoaderLayer').load(contextPath + "/news/newsList?flag=" + flag + "&startLocation=1&keyword=" + keyword + " .newsList",function() {
		$('.mainLoading').hide();
		$('.newsLoaderLayer').show();
		$('.newsMore').show();
		if($('.startLocation').eq(0).val()==0) {
			$('.newsMore').hide();
			$('.newsLoaderLayer').append('<div class = "noResult">검색결과가 없습니다</div>');
		}
	});
	
	// 검색바에 검색어 띄우기
	$('#search').val(keyword);
	
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

// 뉴스 페이지를 몇번 로드했는지를 나타내는 전역변수
let newsMorecnt = 1;
function newsMore() {
	$('.newsMore').hide();
	$('.newsMoreLoading').show();
	let startLocation = $('.startLocation').eq(newsMorecnt-1).val();
	if(startLocation==0 || startLocation>1000) {
		$('.newsMoreLoading').hide();
		$('.newsLoaderLayer').append('<div class = "noResult">검색결과가 없습니다</div>');
		return false;
	}
	let str = '<div class = "newMoreLayer'+newsMorecnt+'"></div>';
	$('.newsLoaderLayer').append(str);
	
	$('.newMoreLayer' + newsMorecnt).load(contextPath + "/news/newsList?startLocation=" + startLocation + "&keyword=" + keyword + " .newsList" , function() {
		$('.newsMore').show();
		$('.newsMoreLoading').hide();
		$('#startLocation').val()
	});
	
	newsMorecnt++;
}
