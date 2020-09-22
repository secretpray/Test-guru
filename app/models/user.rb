class User < ApplicationRecord
  has_many :tests_users
  # has_and_belongs_to_many :tests
  has_many :tests, through: :tests_users # получить тесты через таблицу tests_users, а не из tests_users
  has_many :created_tests, class_name: 'Test', foreign_key: 'author_id' #  User.first.created_tests & Test.last.author_id
  
  validates :first_name, :last_name, :email, :login, :password_digest, presence: true
  validates_email_format_of :email, :message => 'Email format looks invalid. Did you mistype?' # ,:allow_nil => true
  # validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, uniqueness: true
  # validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true

  # def by_level(level)
  #   # Test.joins('JOIN tests_users ON tests.id = tests_users.test_id').where(tests_users: {user_id: id}).where(level: level)
  #   self.tests.where("level = :level", level: level).distinct
  # end
end
