class TestsController < ApplicationController

  # before_action :find_category, only: %i[index new create]
  before_action :find_test, only: %i[show destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index
    render plain: Test.all.name_sorted
  end

  def show
    render inline:  "<p>Тест №<%=params[:id]%> категории '<%=@test.title%>':</p>"\
                    '<h1><%= @test.title %></h1><ul><% @test.questions.each do |question| %>'\
                    '<li><%= question.body %></li><% end %></ul></ul><div>'
  end

  def new; end

  def search
    result = ["Class: #{params.class}", "Parameters: #{params.inspect}"]
    render plain: result.join("\n")
  end

  def create
    @category = Category.last
    test = @category.tests.new(test_params)

    if test.save
     redirect_to action: :index
    else
      render plain: "Тест не соотвествует требованиям!"
    end
  end

  def start
    render html: '<h1>Start certain test..</h1>'.html_safe
  end

  private

  def test_params
    params.require(:test).permit(:title, :level)
  end

  def find_test
    @test = Test.find(params[:id])
  end

  def rescue_with_test_not_found
    render plain: 'Test was not found'
  end
end
