class User < ApplicationRecord
  MAX_EMAIL_STRING = 50

  devise  :database_authenticatable,
          :registerable,
          :confirmable,
          :recoverable,
          :rememberable,
          :validatable

  has_many :gists, dependent: :destroy
  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages

  validates :first_name, :last_name, :email, :login, presence: true
  validates :login, presence: true, uniqueness: true
  validates :email, length: { maximum: MAX_EMAIL_STRING }, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true

  def by_level(level)
    tests.where(level: level)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

  def admin?
    is_a?(Admin)
  end
end
