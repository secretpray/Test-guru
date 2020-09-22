class User < ApplicationRecord
  has_many :tests_users
  has_many :tests, through: :tests_users 
  has_many :created_tests, class_name: 'Test', foreign_key: 'author_id'
  
  validates :first_name, :last_name, :email, :login, :password_digest, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true

  def by_level(level)
    tests.where("level = :level", level: level).distinct # tests.where(level: level)
  end
end
