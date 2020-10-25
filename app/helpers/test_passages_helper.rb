module TestPassagesHelper

  def result_color_and_percent(percent)
    if @test_passage.successfull_test?
      "<h2 style='color: green'>You answered #{percent}% questions.
      Test successfully passed!</h2>".html_safe
    else
      "<h2 style='color: red'>You answered #{percent}% questions.
      Test failed!</h2>".html_safe
    end
  end

  def progress_percent(current_question_index, questions_count)
    (((current_question_index - 1).to_f / questions_count.to_f) * 100).to_i
  end
end
