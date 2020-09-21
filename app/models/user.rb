class User < ApplicationRecord
  has_many :tests_users
  # has_and_belongs_to_many :tests
  has_many :tests, through: :tests_users # получить тесты через таблицу tests_users, а не из tests_users
  has_many :created_tests, class_name: 'Test', foreign_key: 'author_id' #  User.first.created_tests & Test.last.author_id
  
  def by_level(level)
    Test.joins('JOIN tests_users ON tests.id = tests_users.test_id').where(tests_users: {user_id: id}).where(level: level)
    # self.tests.where("level = :level", level: level).distinct
  end
end
