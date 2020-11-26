document.addEventListener('turbolinks:load', function() {

  // Timeout hide flash
  let alert = document.getElementById('alert');
  if (alert) fadeOut(alert, 5000)

  // Timeout hide error
  let errs = document.getElementById('errors');
  if (errs) fadeOut(errs, 7000)

  // Timeout hide Devise error
  let deviseErrorExplanation = document.getElementById('error_explanation');
  if (deviseErrorExplanation) fadeOut(deviseErrorExplanation, 7000)

  function fadeOut(object, time) {
    window.setTimeout(function() {
      object.classList.add('fade-out')
    }, time);
  }

  // function hideAlert(id, time) {
  //   const alert = document.getElementById(id);
  //    if (alert) {
  //      window.setTimeout(function() {
  //        alert.classList.add('fade-out')
  //      }, 5000);
  //    }
  // }
  // hideAlert('alert', 5000)
  // hideAlert('errors', 7000)

  //Nav menu hide
  const sidebar = document.querySelector('.sidebar');
  const footer = document.querySelector('#page-footer');
  const hambicon = document.querySelector(".menu-icon");

  if (localStorage.getItem('sidebar') == 'true') {
    sidebar.classList.add("active");
    footer.classList.add("active");
    hambicon.classList.add("active");
    localStorage.removeItem('sidebar');

  };

  if (hambicon) {
    hambicon.addEventListener("click", function() {
      sidebar.classList.toggle("active");
      footer.classList.toggle("active");
      hambicon.classList.toggle("active");
      })
    }

  //Language checkBox for change text (Russian to English) on click
  const lang = document.querySelector('.text-lang')
  const toggleLang = document.querySelector('.toggle-lang')

  if (toggleLang) {
    toggleLang.addEventListener('click', function(){
      lang.classList.toggle('en');

      if (document.querySelector('.sidebar').classList.contains("active")) {
        localStorage.setItem('sidebar', 'true');
      }

      if (lang.classList.contains('en')) {
          location.replace("?lang=en");
        } else {
          location.replace("?lang=ru");
      }
    })
  }

  // Clock
  const deg = 6;
  const hr = document.querySelector("#hr");
  const mn = document.querySelector("#mn");
  const sc = document.querySelector("#sc");

  if (hr) {
    setInterval(() => {
        let day = new Date();
        let hh = day.getHours() * 30;
        let mm = day.getMinutes() * deg;
        let ss = day.getSeconds() * deg;

        hr.style.transform = `rotateZ(${(hh) + (mm/12)}deg)`;
        mn.style.transform = `rotateZ(${mm}deg)`;
        sc.style.transform = `rotateZ(${ss}deg)`;
    })
  }
});

