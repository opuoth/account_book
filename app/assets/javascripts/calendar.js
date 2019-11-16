{const weeks = ['日','月','火','水','木','金','土'];
const date = new Date();
var year = date.getFullYear();
var month = date.getMonth()+1;

function showCalendar(year, month){
  const calendarHtml = createCalendar(year, month);
  const sec = document.createElement('section');
  sec.innerHTML = calendarHtml;
  if(document.querySelector('#calendar')!=null){
    document.querySelector('#calendar').appendChild(sec);
  }
}

function createCalendar(year, month){
  const startDate = new Date(year, month-1, 1);
  const endDate = new Date(year, month, 0);
  const endDayCount = endDate.getDate();
  const lastMonthEndDate = new Date(year, month-1,0);
  const lastMonthEndDayCount=lastMonthEndDate.getDate();
  const startDay = startDate.getDay();
  let dayCount = 1;
  let calendarHtml = '';

  calendarHtml += '<h1>' + year + '/' + month + '</h1>';
  calendarHtml += '<table>'

  for (let i=0; i<weeks.length; i++){
    calendarHtml += '<td>' + weeks[i] + '</td>';
  }

  for(let w=0; w<6 ; w++){
    calendarHtml += '<tr>';

    for(let d=0; d<7; d++){
      if(w==0&&d<startDay){
        let num = lastMonthEndDayCount-startDay+d+1;
        calendarHtml += '<td class="is-disabled">'+num+'</td>';
      }else if(dayCount>endDayCount){
        let num = dayCount - endDayCount;
        calendarHtml += '<td class="is-disabled">'+num+'</td>';
        dayCount++;
      }else {
        calendarHtml += `<td class="calendar_td" data-date="${year}/${month}/${dayCount}">`+dayCount+'</td>';
        dayCount++;
      }
    }
    calendarHtml += '</tr>';
  }

  calendarHtml += '</table>';

  return calendarHtml;
}

function moveCalendar(e) {
    document.querySelector('#calendar').innerHTML = ''

    if (e.target.id === 'prev') {
        month--

        if (month < 1) {
            year--
            month = 12
        }
    }

    if (e.target.id === 'next') {
        month++

        if (month > 12) {
            year++
            month = 1
        }
    }

    showCalendar(year, month)
}

if (document.getElementById('prev') != null) {
  document.getElementById('prev').addEventListener('click', moveCalendar)
}
if (document.getElementById('next') != null) {
  document.getElementById('next').addEventListener('click', moveCalendar)
}

document.addEventListener("click", function(e) {
  if(e.target.classList.contains("calendar_td")) {
      // alert('クリックした日付は' + e.target.dataset.date + 'です');
      $('.select').removeClass('select');
      e.target.classList.add("select");
  }
});

showCalendar(year, month);}
