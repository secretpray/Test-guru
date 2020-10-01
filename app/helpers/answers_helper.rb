module AnswersHelper
  def answer_header(answer)
    action = answer.new_record? ? 'Create New' : 'Edit'
    "#{action} Answer for Question \"#{answer.question.body}\""
  end
end
