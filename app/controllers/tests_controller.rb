class TestsController < ApplicationController

  # skip_before_action :find_test, only: :show # в каких случая пропустить, м.б. массив (новый пользователь -> reg)
  # before_action :find_category, only: %i[index new create]
  before_action :find_test, only: %i[show destroy] #, only: %i[show] только перед вызовом метода show
  after_action :send_log_message
  around_action :log_execute_time

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index
    tests = Test.all
    render plain: Test.all.name_sorted
    # render plain: 'All tests'
    # render html: '<h1>All tests</h1>'.html_safe
    # render json: { tests: Test.all } # render json: { tests: [] }
    # render inline: '<p>My favourite language is: <%= %[ybuR].reverse! %>!</p>'
    # render file: 'public/hello' #, layout: false
    # head 204 # all ok but return nothing
    # head :no_content
    # render inline: '<%= console %>'
    # logger.info(self.object_id)

    # respond_to do |format|
    #   # format.html { render plain: 'All tests' }
    #   format.html { render inline: '<p>All tests: <%= Test.all %> </p>'}
    #   format.json { render json: { tests: Test.name_sorted }}
    # end
    # byebug
    # result = ["Class: #{params.class}", "Parameters: #{params.inspect}"]
    # render plain: result.join("\n")
  end

  def show
    # buybug
    # redirect_to root_path
    # redirect_to tests_path # test_path or test_path(2), new_test_path, edit_test_path, test_path(Test.first)
    # render plain: 'Show test'
    # redirect_to 'https://rubyonrails.org'
    # render inline: '<%= @test.title %>'
    render inline:  "<p>Тест №<%=params[:id]%> категории '<%=@test.title%>':</p>"\
                    '<h1><%= @test.title %></h1><ul><% @test.questions.each do |question| %>'\
                    '<li><%= question.body %></li><% end %></ul></ul><div>'
  end

  def new
    # #params[:controller]
    # controller_name
    # action_name
  end

  def search
    result = ["Class: #{params.class}", "Parameters: #{params.inspect}"]
    render plain: result.join("\n")
  end

  def create
    # result = ["Class: #{params.class}", "Parameters: #{params.inspect}"]
    # render plain: result.join("\n")
    test = Test.create(test_params)
    render plain: test.inspect
  end

  def start
    # render plain: 'Start certain test...'
    render html: '<h1>Start certain test..</h1>'.html_safe
  end

  private

  def test_params
    params.require(:test).permit(:title, :level)
  end

  def find_test
    @test = Test.find(params[:id])
  end

  def find_category
    @category = Category.find(params[:id])
  end

  def send_log_message
    logger.info("Action [#{action_name}] was finished")
  end

  def log_execute_time
    start = Time.now
    yield
    finish = Time.now - start

    logger.info("Execution time: #{finish * 1000}ms")
  end

  def rescue_with_test_not_found
    render plain: 'Test was not found'
  end
end
