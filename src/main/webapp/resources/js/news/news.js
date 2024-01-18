'use strict';
let colors = ['#ec4d4d','#f99236','#7ddc02','#23c226','#23c28b','#23bdc2','#2374c2','#2345c2','#8623c2','#e70086'];

$(function() {
	// 키워드 색깔 랜덤 지정
	let items = $('.keyword');
	
	for(let item of items) {
		let random = Math.floor(Math.random()*10);
		$(item).css('background-color',colors[random]);
	}
	
});