document.addEventListener('turbolinks:load', function() {
  let controls = document.querySelectorAll('.form-inline-link')

  if (controls.length) {
    for (let i = 0; i < controls.length; i++) {
      controls[i].addEventListener('click', formInlineLinkHandler)
    }
  }

  let errors = document.querySelector('.resource-errors')

  if (errors) {
    let resourceId = errors.dataset.resourceId
    formInlineHandler(resourceId)
  }
})

function formInlineLinkHandler(event) {
  event.preventDefault()

  let testId = this.dataset.testId
  formInlineHandler(testId)
}

function formInlineHandler(testId) {
  let testDataAttr = `[data-test-id="${testId}"]`;
  let link = document.querySelector('.form-inline-link' + testDataAttr)
  let testTitle = document.querySelector('.test-title' + testDataAttr)
  let formInline = document.querySelector('.form-inline' + testDataAttr)
 

  if (formInline.classList.contains('hide')) {
    testTitle.classList.add('hide')
    formInline.classList.remove('hide')
    link.textContent = link.dataset.cancelLabel
  } else {
    testTitle.classList.remove('hide')
    formInline.classList.add('hide')
    link.textContent = link.dataset.editLabel
  }
}
