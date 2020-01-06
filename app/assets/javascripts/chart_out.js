(function(){
  'use strict';

  var type = 'doughnut';

  var data = {
    labels: gon.label_out,
    datasets: [{
      data: gon.data_out,
      backgroundColor: ['orange','skyblue','pink','palegreen','mediumorchid']
    }]
  };

  var options = {
    cutoutPercentage: 40,
    title: {
      display: true,
      text: gon.month+'月の支出',
      fontSize: 20
     }
  };

  var ctx = document.getElementById('chart_out').getContext('2d');
  var myChart = new Chart(ctx, {
    type: type,
    data: data,
    options: options
  })
})();
