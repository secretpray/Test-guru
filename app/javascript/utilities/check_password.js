document.addEventListener('turbolinks:load', function() {
  let titleInput = document.getElementById('test_title')
  let levelInput= document.getElementById('test_level')
  let titleLabel = document.querySelector('.title-label')
  let levelLabel = document.querySelector('.level-label')
  let forgotPasswordInput = document.getElementById('user_email')
  let forgotPasswordLabel = document.querySelector('.forgot-password-label')
  let feedbackTitleInput = document.getElementById('feedback_title')
  let feedbackTitleLabel = document.querySelector('.feedback-title-label')
  let feedbackBodyInput = document.getElementById('feedback_body')
  let feedbackBodyLabel = document.querySelector('.feedback-body-label')
  let control = document.querySelectorAll('input[type=password]')
  let submitButton = document.querySelector('.signin-button')

  // Валидация форм создания теста
  hideLabel(titleInput, titleLabel)

  // Валидация формы создания отзыва
  hideLabel(feedbackTitleInput, feedbackTitleLabel)
  hideLabel(feedbackBodyInput, feedbackBodyLabel)


  // Валидация формы восстановления пароля
  hideLabel(forgotPasswordInput, forgotPasswordLabel)

  function hideLabel(input, label) {
    if (input) {
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

  if (levelInput) {
  levelInput.addEventListener('focus', function() {
    levelLabel.classList.add('hidden');
  });
  levelInput.addEventListener('blur', function() {
    if (+levelInput.value < 0 || +levelInput.value > 100 ) {
      levelInput.value = '';
      levelLabel.classList.remove('hidden');
    } else {
      levelLabel.classList.add('hidden');
    }
    });
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
