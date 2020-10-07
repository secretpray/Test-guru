class Admin::TestsController < Admin::BaseController

  before_action :find_test, only: %i[show edit update destroy start]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index
    @tests = Test.all
  end

  def show; end

  def new
    @test = Test.new
  end

  def edit; end

  def create
    @test = Test.new(test_params)
    # @test = current_user.own_tests.new(test_params)

    if @test.save
     redirect_to [:admin, @test], notice: 'Вопрос сохранен.'
    else
      render :new
    end
  end

  def update
    if @test.update(test_params)
      redirect_to [:admin, @test], notice: 'Вопрос изменен.'
    else
      render :edit
    end
  end

  def destroy
    @test.destroy
    redirect_to admin_tests_path, notice: 'Вопрос удален.'
  end

  def start
    @user.tests.push(@test)
    redirect_to @user.test_passage(@test)
  end

  private

  def test_params
    params.require(:test).permit(:title, :level, :author_id, :category_id)
  end

  def find_test
    @test = Test.find(params[:id])
  end

  def set_user
    @user = User.first
  end

  def rescue_with_test_not_found
    render plain: 'Test was not found'
  end
end
