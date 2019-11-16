(function(){
  'use strict';

  var type = "line";

  var data = {
    labels: [1,2,3,4,5],
    datasets: [{
      label: '収入',
      data: [100,200,500,400,300],
      borderColor: 'rgba(255,0,0,0.5)',
      borderWidth: 5,
      backgroundColor: 'rgba(255,0,0,0.1)'
    },{
      label: '支出',
      data: [30,100,300,700,100],
      borderColor: 'skyblue',
      borderWidth: 5,
      backgroundColor: 'rgba(0,0,255,0.1)'
    }]
  }

  var options ={
    scales: {
      yAxes: [{
        ticks: {
          suggestedMin: 0,
          suggestedMax:800,
          callback: function(value,index,values) {
            return 'JPY'+value;
          }
        }
      }],
      xAxes: [{
        ticks:{
          callback: function(value,index,values) {
            return value+'日';
          }
        }
      }]
    },
    title: {
      display:true,
      text: '1ヶ月の収入と支出',
      fontSize:18,
    },
    legend: {
      position: 'bottom'
    }
  };

  var ctx=document.getElementById('gragh').getContext('2d');
  var myChart = new Chart(ctx, {
    type: type,
    data: data,
    options: options
  })
})();
