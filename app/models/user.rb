require 'digest/sha1'

class User < ApplicationRecord
  include Auth

  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages
  has_many :created_tests, class_name: 'Test', foreign_key: 'author_id',
                           inverse_of: :author, dependent: :destroy

  has_secure_password

  validates :first_name, :last_name, :email, :login, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  # validates :password, confirmation: true
  # validates :password, presence: true, if: Proc.new { |user| user.password_digest.blank? }

  def by_level(level)
    tests.where(level: level)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end
end
