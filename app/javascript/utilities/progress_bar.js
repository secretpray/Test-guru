document.addEventListener('turbolinks:load', function() {
  const progressBar = document.querySelector('.progress-bar')

  if (progressBar) {
    const currentQuestionIndex = progressBar.dataset.currentQuestionIndex
    const questionsCount = progressBar.dataset.questionsCount
    const testPassageTitle = progressBar.dataset.testPassageTitle

    const check = ((currentQuestionIndex / questionsCount) * 100);
    const percentage = Math.round((currentQuestionIndex / questionsCount) * 100) + '%'
    const percentageTitle = `"${testPassageTitle}": ( ${percentage} )`

    progressBar.style.width = percentage;

    if (check > 0 ) {
      progressBar.classList.add("progress-bar-striped");
      progressBar.classList.add('progress-bar-animated');
      progressBar.textContent = percentageTitle;
    } else {
      progressBar.style.width = '100%';
      progressBar.style.backgroundColor = '';
      progressBar.textContent = `"${testPassageTitle}"`;
    }

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
