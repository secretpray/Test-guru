Category.delete_all
Question.delete_all
Answer.delete_all
TestPassage.delete_all
Test.delete_all
User.delete_all
USERS = [
  { first_name: 'Петр', last_name: 'Немов', email: 'nemov@mail.com', login: 'nemov', type: "Admin", password: 'secretus', confirmed_at: Time.now },
  { first_name: 'Александр', last_name: 'Иванов', email: 'alex@mail.com', login: 'alex', password: 'secretus', confirmed_at: Time.now },
  { first_name: 'Максим', last_name: 'Петров', email: 'max@mail.com', login: 'max', password: 'secretus', confirmed_at: Time.now },
  { first_name: 'Дмитрий', last_name: 'Сидоров', email: 'dim@mail.com', login: 'dim', password: 'secretus', confirmed_at: Time.now },
  { first_name: 'Антон', last_name: 'Ткаченко', email: 'antm@mail.com', login: 'ant', password: 'secretus', confirmed_at: Time.now },
  { first_name: 'Сергей', last_name: 'Симонов', email: 'sss@mail.com', login: 'sss', password: 'secretus', confirmed_at: Time.now }
]
USERS.each do |user|
  User.create!(user)
end
DATA_TEST =
[
   frontend: {
     html: { 'Как расшифровывается HTML?' => ['Hyper Text Markup Language', 'Home Tool Markup Language', 'Hyperlinks and Text Markup Language'] },
     css:  { 'CSS-код: body {font-size: 14pt;} p {font-size: 2em;}. Какой размер текста будет в теге <p>:' => %w[28pt 16pt 7pt 12pt] },
     flash: { 'Событие ENTER_FRAME зависит от частоты кадров SWF файла?' =>  %w[Yes No] }
   },
   backend:  {
     php:  { 'Что будет в переменной $result после выполнения кода $result = 2 ** 3;?' => %w[8 6 2 4] },
     rails: { 'Какая библиотека в Rails служит для объектно-реляционного отображения?' => ['Active Record', 'Camelcase', 'Web page', 'Underscores']},
     javascript: { 'Какая из этих функций вернет число: parseFloat("$101.2") и parseFloat("101.2 USD")?' => ['Ни одна изх них', 'parseFloat("101.2 USD")', 'parseFloat("$101.2")']}
   }
 ]
# create category-tests-question-answer
DATA_TEST.first.each do |category, tests|
 db_category = Category.create!(title: category)
 tests.each do |test, questions|
   db_test = Test.create!(title: test, author_id: Admin.first.id, level: rand(0..5), category_id: db_category.id)
   questions.each do |question, answers|
     db_question = Question.create!(body: question, test_id: db_test.id)
     answers.each_with_index do |answer, index|
       Answer.create!(body: answer, correct: index.zero?, question_id: db_question.id)
     end
   end
 end
end
User.all.each do |user|
  current_user = user
  Test.all.each do |test|
    TestPassage.find_or_create_by(user_id: current_user.id, test_id: test.id, current_question_id: rand(1..Question.count))
  end
end