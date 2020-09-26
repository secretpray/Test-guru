class QuestionsController < ApplicationController

  before_action :find_test, only: %i[index new create]
  before_action :find_question, only: %i[show destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    render inline: '<h2><%= @test.title %></h2><ul><% @test.questions.each do |question| %><li><%= link_to question.body,'\
                    ' question_path(question) %></li><% end %></ul><div><%= link_to \'Новый вопрос\', { controller: "questions", action: "new" } %></div>'
  end

  def show
    render inline:  "<p>Вопрос №<%=params[:id]%> теста '<%=@question.test.title%>':</p>"\
                    '<h1><%= @question.body %></h1><ul><% @question.answers.shuffle.each do |answer| %>'\
                    '<li><%= answer.body %></li><% end %></ul></ul><div>'
  end

  def destroy
    @question.destroy
  
    redirect_to test_questions_path(@question.test), notice: 'Вопрос удален.'
  end

  def create
    question = @test.questions.new(question_params)

    if question.save
      redirect_to action: :index
    else
      render plain: "Вопрос не соотвествует требованиям!"
    end
  end

  def new; end

  private

  def question_params
    params.require(:question).permit(:body)
  end

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def rescue_with_question_not_found
    render plain: 'Вопрос не найден!'
  end
end
