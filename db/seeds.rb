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

DATA_TEST.first.each do |category, tests|
 # category create
 db_category = Category.find_or_create_by(title: category)
 tests.each do |test, questions|
   # create test
   db_test = Test.find_or_create_by(title: test, level: rand(1..3), category_id: db_category.id)
   questions.each do |question, answers|
     #create question
     db_question = Question.find_or_create_by(body: question, test_id: db_test.id)
     answers.each_with_index do |answer, index|
       # create answer
       Answer.find_or_create_by(body: answer, correct: index.zero?, question_id: db_question.id)
     end
   end
 end
end

# create user
USER_DATA = [%w[Александр Иванов alex@mail.com alex 12345], %w[Максим Петров max@mail.com max 12321], %w[Дмитрий Сидоров dim@mail.com dim 54321]]

USER_DATA.each do |item|
  User.find_or_create_by(first_name: item[0], last_name: item[1], email: item[2], login: item[3], password_digest: item[4])
end

# create UserTest
User.all.each do |user|
  current_user = user 
  Test.all.each do |test|
    UserTest.find_or_create_by(user_id: current_user.id, test_id: test.id)
  end
end
# user1 = User.all.find_by(id: 1)
# user2 = User.all.find_by(id: 2)
# user3 = User.all.find_by(id: 3)
# test1 = Test.all.find_by(id: 1)
# test2 = Test.all.find_by(id: 2)
# test3 = Test.all.find_by(id: 3)

# UserTest.create(
#                 [{ user_id: user1.id, test_id: test1.id },
#                  { user_id: user2.id, test_id: test2.id },
#                  { user_id: user3.id, test_id: test3.id }]
#                 )
