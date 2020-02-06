(function(){
  'use strict';

  var today = new Date();

  var date_set = [...Array(today.getDate())].map((v,i)=>i+1);

  var type = "line";

  var data = {
    labels: date_set,
    datasets: [{
      label: '支出',
      data: gon.data1,
      borderColor: 'rgba(255,0,0,0.5)',
      borderWidth: 5,
      backgroundColor: 'rgba(255,0,0,0.1)'
    },{
      label: '収入',
      data: gon.data2,
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
      text: gon.year+'年'+gon.month+'月(今日まで)の収入と支出の推移',
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
