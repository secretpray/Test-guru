class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :validate_max, on: [ :create, :update ]

  scope :correct, -> { where(correct: true) }

  def validate_max
    errors.add(:base, 'Не больше 4 ответов') if question.answers.count > 4
  end

end
