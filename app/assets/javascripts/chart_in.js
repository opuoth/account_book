(function(){
  'use strict';

  var type = 'doughnut';

  var data = {
    labels: gon.label_in,
    datasets: [{
      data: gon.data_in,
      backgroundColor: ['orange','skyblue','pink','palegreen','mediumorchid','mediumseagreen','lightcoral','sandybrown','turquoise','plum','wheat','lightgray','palegoldenrod','tomato','greenyellow']
    }]
  };

  var options = {
    cutoutPercentage: 40,
    title: {
      display: true,
      text: gon.year+'年'+gon.month+'月(今日まで)の収入',
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
