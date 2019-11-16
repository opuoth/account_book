(function(){
  'use strict';

  var type = 'doughnut';

  var data = {
    labels: ['食費','交際費','美容'],
    datasets: [{
      data: [122,53,33],
      backgroundColor: ['orange','skyblue','pink']
    }]
  };

  var options = {
    cutoutPercentage: 40
  };

  var ctx = document.getElementById('my_chart').getContext('2d');
  var myChart = new Chart(ctx, {
    type: type,
    data: data,
    options: options
  })
})();
