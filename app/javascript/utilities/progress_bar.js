document.addEventListener('turbolinks:load', function() {
  const progressBar = document.querySelector('.progress-bar')

  if (progressBar) {
    const currentQuestionIndex = progressBar.dataset.currentQuestionIndex
    const questionsCount = progressBar.dataset.questionsCount

    const percentage = ((currentQuestionIndex / questionsCount) * 100) + '%'

    progressBar.style.width = percentage;
    progressBar.textContent = percentage;
  }
})

document.addEventListener('turbolinks:load', function() {
  const diagramm = document.querySelector('.percent_circle_diagramm')

  if (diagramm) {
    const texts = diagramm.querySelectorAll('.percent_text')
    const circle = diagramm.querySelector('.percent_circle')
    let currentQuestionIndex = diagramm.dataset.currentQuestionIndex
    let questionsCount = diagramm.dataset.questionsCount
    let percentage = Math.floor((currentQuestionIndex / questionsCount) * 100)
    texts.forEach(node => (node.textContent = percentage));

    const circlePart = 440 - (440 * percentage) / 100;
    circle.setAttribute('style', `stroke-dashoffset: ${circlePart};`);
  }
})
