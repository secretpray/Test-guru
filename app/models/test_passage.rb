# frozen_string_literal: true

class TestPassage < ApplicationRecord
  PASSED_SUCCESS_PERCENT = 85

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true
  before_validation :before_validation_set_next_question

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    save!
  end

  def completed?
    current_question.nil?
  end

  def success_percent
    ((correct_questions.to_f / test.questions.count) * 100.0).round
  end

  def success?
    success_percent >= PASSED_SUCCESS_PERCENT
  end

  def current_question_number
    test.questions.where('id <= :id', id: current_question.id).count
  end

  private

  def before_validation_set_next_question
    self.current_question = next_question
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == Array(answer_ids).map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    if current_question.nil?
      test.questions.first
    else
      test.questions.order(:id).find_by('id > :id', id: current_question.id)
    end
  end
end
