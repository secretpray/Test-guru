module QuestionsHelper

  def question_header(question)
    action = question.new_record? ? t('.create') : t('.edit')
    "#{action} #{t('.question')}"
  end
end
