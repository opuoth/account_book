(function(){
  'use strict';

  var type = 'doughnut';

  var data = {
    labels: gon.label_in,
    datasets: [{
      data: gon.data_in,
      backgroundColor: ['orange','skyblue','pink','palegreen','mediumorchid']
    }]
  };

  var options = {
    cutoutPercentage: 40,
    title: {
      display: true,
      text: '12月の収入',
      fontSize: 20
    }
  };

  var ctx = document.getElementById('chart_in').getContext('2d');
  var myChart = new Chart(ctx, {
    type: type,
    data: data,
    options: options
  })
})();
