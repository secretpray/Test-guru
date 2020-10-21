document.addEventListener('turbolinks:load', function() {
  let control = document.querySelectorAll('input[type=password]')

  if (control) {
    for(let i = 0; i < control.length; i++) {
      control[i].addEventListener('input', comparePasswordFields) }
  }
})

  function comparePasswordFields(){
    let newPassword = document.getElementById('user_password')
    let confirmPassword = document.getElementById('user_password_confirmation')
    let passwordConfirmField = document.querySelector('.password_confirm')
    let passwordField = document.querySelector('.password')

    if (newPassword.value == confirmPassword.value && newPassword.value != "" ) {
      newPassword.style.backgroundColor  = "#DFEFCA"
      confirmPassword.style.backgroundColor  = "#DFEFCA"
      passwordField.querySelector('.octicon-check').classList.remove('hide')
      passwordConfirmField.querySelector('.octicon-check').classList.remove('hide')
      passwordConfirmField.querySelector('.password-alert').classList.add('hide')
      $("#submitBtn").attr("disabled",false);
    } else if (newPassword.value == "" || confirmPassword.value == "") {
      newPassword.style.backgroundColor  = "transparent"
      confirmPassword.style.backgroundColor = "transparent"
      passwordField.querySelector('.octicon-check').classList.add('hide')
      passwordConfirmField.querySelector('.octicon-check').classList.add('hide')
      $("#submitBtn").attr("disabled",true);
    } else {
      newPassword.style.backgroundColor  = "#ffe7e7"
      confirmPassword.style.backgroundColor = "#ffe7e7"
      passwordField.querySelector('.octicon-check').classList.add('hide')
      passwordConfirmField.querySelector('.octicon-check').classList.add('hide')
      passwordConfirmField.querySelector('.password-alert').classList.remove('hide')
      $("#submitBtn").attr("disabled",true);
    }
  }
