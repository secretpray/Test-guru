module QuestionsHelper

  def question_header(question)
    action = question.new_record? ? 'Create new' : 'Edit'
    "#{action} question: #{question.body}"
  end
end
