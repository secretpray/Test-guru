document.addEventListener('turbolinks:load', function() {
  let titleInput = document.getElementById('test_title')
  let levelInput= document.getElementById('test_level')
  let timerInput= document.getElementById('test_timer')
  let titleLabel = document.querySelector('.title-label')
  let levelLabel = document.querySelector('.level-label')
  let timerLabel = document.querySelector('.timer-label')
  let forgotPasswordInput = document.getElementById('user_email')
  let forgotPasswordLabel = document.querySelector('.forgot-password-label')
  let feedbackTitleInput = document.getElementById('feedback_title')
  let feedbackTitleLabel = document.querySelector('.feedback-title-label')
  let feedbackBodyInput = document.getElementById('feedback_body')
  let feedbackBodyLabel = document.querySelector('.feedback-body-label')
  let control = document.querySelectorAll('input[type=password]')
  let submitButton = document.querySelector('.signin-button')

  // Валидация форм создания теста
  if (titleInput && titleLabel) {
    hideLabel(titleInput, titleLabel)
  }
  if (levelInput) {
    hideNumberIntervalLabel(levelInput, levelLabel, 0, 100)
  }
  if (timerInput) {
    hideNumberIntervalLabel(timerInput, timerLabel, 0, 60)
  }

  // Валидация формы создания отзыва
  if (feedbackTitleInput) {
    hideLabel(feedbackTitleInput, feedbackTitleLabel)
  }
  if (feedbackBodyInput) {
    hideLabel(feedbackBodyInput, feedbackBodyLabel)
  }


  // Валидация формы восстановления пароля
  if (forgotPasswordInput) {
    hideLabel(forgotPasswordInput, forgotPasswordLabel)
  }

  function hideLabel(input, label) {
    if (input) {
      if (input.value != "") {
      label.classList.add('hidden');
      }
      input.addEventListener('focus', function() {
        label.classList.add('hidden');
      });
      input.addEventListener('blur', function() {
        if (!input.value.length) {
          label.classList.remove('hidden');
        }
      });
    }
  }

  function hideNumberIntervalLabel(inputInterval, labelInterval, min, max) {
    if (inputInterval) {
      inputInterval.addEventListener('focus', function() {
        labelInterval.classList.add('hidden');
      });
      inputInterval.addEventListener('input', validIntervalInput);
      inputInterval.addEventListener('blur', validIntervalInput)
    }
    function validIntervalInput() {
      if (+inputInterval.value < min || +inputInterval.value > max ) {
        inputInterval.value = '';
        labelInterval.classList.remove('hidden');
        inputInterval.style.backgroundColor = "#ffe7e7"
        inputInterval.setAttribute("placeholder", `[${min}..${max}]`);
      } else {
        labelInterval.classList.add('hidden');
        inputInterval.style.backgroundColor = "transparent"
        inputInterval.setAttribute("placeholder", "");
      }
    }
  }

  if (control) {
    for(let i = 0; i < control.length; i++) {
      control[i].addEventListener('input', comparePasswordFields) }
    }

  function comparePasswordFields(){
    let newPassword = document.getElementById('user_password')
    let confirmPassword = document.getElementById('user_password_confirmation')
    let passwordField = document.querySelector('.signin-password')
    let passwordConfirmField = document.querySelector('.signin-password_confirm')

    if (newPassword.value == "" || confirmPassword.value == "") {
      newPassword.style.backgroundColor  = "transparent"
      confirmPassword.style.backgroundColor = "transparent"
      passwordField.querySelector('.octicon-check').classList.add('hide')
      passwordConfirmField.querySelector('.octicon-check').classList.add('hide')
      submitButton.disabled = true;
      submitButton.classList.add('op-10')
      return
    }

    if (newPassword.value == confirmPassword.value && newPassword.value != "" ) {
      newPassword.style.backgroundColor  = "#DFEFCA"
      confirmPassword.style.backgroundColor  = "#DFEFCA"
      passwordField.querySelector('.octicon-check').classList.remove('hide')
      passwordConfirmField.querySelector('.octicon-check').classList.remove('hide')
      passwordConfirmField.querySelector('.password-alert').classList.add('hide')
      submitButton.disabled = false;
      submitButton.classList.remove('op-10')
    } else {
      newPassword.style.backgroundColor  = "#ffe7e7"
      confirmPassword.style.backgroundColor = "#ffe7e7"
      passwordField.querySelector('.octicon-check').classList.add('hide')
      passwordConfirmField.querySelector('.octicon-check').classList.add('hide')
      passwordConfirmField.querySelector('.password-alert').classList.remove('hide')
      submitButton.disabled = true;
      submitButton.classList.add('op-10')
    }

  }
})
