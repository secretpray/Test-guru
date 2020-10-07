
users = User.create([
                      { first_name: 'Ivan', last_name: 'Ivanov',
                        login: 'iivanov', email: 'aaa@bbb.com',
                        password: 'ivanivanov', password_confirmation: 'ivanivanov' },
                      { first_name: 'Alex', last_name: 'Petrov',
                        login: 'apetrov', email: 'aaa@bbb1.com',
                        password: 'alexpetrov', password_confirmation: 'alexpetrov' }
                    ])

users.each{ |user| user.confirm }

admin = Admin.create!(name: 'Andre', surname: 'Adminov',
                       email: 'admin@mail.com',
                       password: '7865_admin',
                       password_confirmation: '7865_admin')
admin.confirm

categories = Category.create!([{title: 'Ruby'},{title: 'Ruby on Rails'}])

tests = []
tests << Test.create!(title: 'Ruby начальный', level: 0, category: categories[0], author: users[0])
tests << Test.create!(title: 'Ruby продвинутый', level: 2, category: categories[0], author: users[0])
tests << Test.create!(title: 'Rails начальный', level: 1, category: categories[1], author: users[1])
tests << Test.create!(title: 'Rails продвинутый', level: 2, category: categories[1], author: users[1])

#TestPassage.create!(user: users[0], test: tests[0])
#TestPassage.create!(user: users[1], test: tests[2])

questions = []
questions << Question.create!(body: 'Укажите результат выражения 1++ ',
                              test: tests[0])
questions << Question.create!(body: 'Какой метод позволяет привести'\
                                 ' строку в нижний регистр:',
                              test: tests[0])

questions << Question.create!(body: 'Чем отличается puts от print:', test: tests[1])
questions << Question.create!(body: 'Создатель Ruby:', test: tests[1])

questions << Question.create!(body: 'В каком году создан Ruby on Rails:',
                             test: tests[2])
questions << Question.create!(body: 'Кто создал Ruby on Rails:', test: tests[2])
questions << Question.create!(body: ' MVC это:', test: tests[3])
questions << Question.create!(body: 'Наследником какого класса' \
                                  ' представлена модель:',
                              test: tests[3])

Answer.create!(body: '1', correct: false, question_id: questions[0].id)
Answer.create!(body: '2', correct: true, question_id: questions[0].id)
Answer.create!(body: '4', correct: false, question_id: questions[0].id)

Answer.create!(body: 'lowercase()', correct: false, question_id: questions[1].id)
Answer.create!(body: 'down()', correct: false, question_id: questions[1].id)
Answer.create!(body: 'downcase()', correct: true, question_id: questions[1].id)

Answer.create!(body: 'Ничем, оба делают одно и тоже',
               correct: true,
               question_id: questions[2].id)
Answer.create!(body: 'print без пропуска строки, а puts с пропуском',
               correct: true,
               question_id: questions[2].id)
Answer.create!(body: 'puts позволяет выводить переменные,' \
                               ' а print только текст',
               correct: false,
               question_id: questions[2].id)

Answer.create!(body: 'Билл Гейтц', correct: false, question_id: questions[3].id)
Answer.create!(body: 'Марк Цукербург', correct: false, question_id: questions[3].id)
Answer.create!(body: 'Юкихиро Мацумото', correct: true, question_id: questions[3].id)

Answer.create!(body: '2004-2005', correct: true, question_id: questions[4].id)
Answer.create!(body: '1974-1978', correct: false, question_id:  questions[4].id)
Answer.create!(body: '2008', correct: false, question_id:  questions[4].id)

Answer.create!(body: 'Юкихиро Мацумото', correct: false, question_id: questions[5].id)
Answer.create!(body: 'Билл Гейтц', correct: false, question_id: questions[5].id)
Answer.create!(body: 'Давид Ханссон', correct: true, question_id: questions[5].id)

Answer.create!(body: 'Model, View, Controller',
               correct: true,
               question_id:  questions[6].id)
Answer.create!(body: 'Mobile, Version, Constant',
               correct: false,
               question_id:  questions[6].id)
Answer.create!(body: 'Movie, View, Cinema',
               correct: false,
               question_id:  questions[6].id)

Answer.create!(body: 'ActionFiction', correct: false, question_id: questions[7].id)
Answer.create!(body: 'ActiveData', correct: false, question_id:  questions[7].id)
Answer.create!(body: 'ActiveRecord', correct: true, question_id:  questions[7].id)
