// document.addEventListener('turbolinks:load', function() {
//   const timer = document.querySelector('.timer')

//   if (timer) {
//     let initialTimer = timer.dataset.timer
//     let timeLeft = timer.dataset.timer

//     setInterval(function() {
//       if (timeLeft > 0) {
//         timeLeft -= 1
//       } else {
//         alert(I18n.time_up)
//         document.querySelector('form').submit()
//       }

//       minute = parseInt(timeLeft / 60)
//       second = timeLeft % 60
//       formatSecond = second < 10 ? `0${second}` : second
//       resultTime = `${minute}:${formatSecond}`
//       persent = Math.round((timeLeft / initialTimer) * 100) + "%"
//       timer.innerHTML = `${resultTime} (${persent})`
//     }, 1000)
//   }
// })
