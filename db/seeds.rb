# bin/rails c; load './db/seeds.rb'
# create user
USERS = [
  { first_name: 'Александр', last_name: 'Иванов', email: 'alex@mail.com', login: 'alex', password_digest: '12345' },
  { first_name: 'Максим', last_name: 'Петров', email: 'max@mail.com', login: 'max', password_digest: '54321' },
  { first_name: 'Дмитрий', last_name: 'Сидоров', email: 'dim@mail.com', login: 'dim', password_digest: '54321' },
  { first_name: 'Антон', last_name: 'Ткаченко', email: 'antm@mail.com', login: 'ant', password_digest: '5557721' },
  { first_name: 'Сергей', last_name: 'Симонов', email: 'sss@mail.com', login: 'sss', password_digest: '09054321' }
]
USERS.each do |user|
  User.find_or_create_by(user)
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
 # category create
 db_category = Category.find_or_create_by(title: category)
 tests.each do |test, questions|
   # create test
   db_test = Test.find_or_create_by(title: test, author_id: rand(0..User.count), level: rand(1..3), category_id: db_category.id)
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

# create tests_users
User.all.each do |user|
  current_user = user 
  Test.all.each do |test|
    TestsUser.find_or_create_by(user_id: current_user.id, test_id: test.id)
  end
end


# USER_DATA = [%w[Александр Иванов alex@mail.com alex 12345], %w[Максим Петров max@mail.com max 12321], %w[Дмитрий Сидоров dim@mail.com dim 54321]]

# USER_DATA.each do |item|
#   User.find_or_create_by(first_name: item[0], last_name: item[1], email: item[2], login: item[3], password_digest: item[4])
# end

# User.create([{ :first_name => 'Anton', :last_name => 'Gondon', :email => 'gnd@mail.com' , :login => 'gondon', :password_digest => 12222222 }])
# #
# TestsUser.create(
#                 [{ user_id: User.last.id, test_id: 6 },
#                  { user_id: User.last.id, test_id: 2 },
#                  { user_id: User.last.id, test_id: 4 }]
#                 )
# level 2 (test.id 6), level 3 (2, 4)