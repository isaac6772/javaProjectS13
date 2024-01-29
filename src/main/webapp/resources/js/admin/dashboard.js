'use strict';

google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawVisualization);
google.charts.setOnLoadCallback(drawChart);
google.charts.setOnLoadCallback(drawDonut);

function drawVisualization() {
	
	let data = google.visualization.arrayToDataTable(boardData);

    let options = {
		seriesType: 'bars',
		animation:{
			startup: true,
	        duration: 850,
	        easing: 'out'
      	}
    };

	let chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
	chart.draw(data, options);
}

function drawChart() {
    var data = google.visualization.arrayToDataTable(joinData);

    var options = {
  		curveType: 'function',
  		legend: { position: 'bottom' },
  		animation:{
			startup: true,
	        duration: 850,
	        easing: 'out'
      	}
    };

    var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

    chart.draw(data, options);
}

function drawDonut() {
    var data = google.visualization.arrayToDataTable(keywordData);

    var options = {
      	pieHole: 0.4,
      	fontSize : 16,
      	chartArea : {width:350,height:300}
    };

    var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
	chart.draw(data, options);
}