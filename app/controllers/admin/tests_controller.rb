class Admin::TestsController < Admin::BaseController

  before_action :set_tests, only: %i[index update_inline]
  before_action :find_test, only: %i[show edit update update_inline destroy]


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
    @test = current_user.created_tests.new(test_params)

    if @test.save
     redirect_to [:admin, @test], notice: t('.success', badge: @test.title )
    else
      flash[:notice] = t('.not_success', badge: @test.title)
      render :new
    end
  end

  def update
    if @test.update(test_params)
      redirect_to [:admin, @test], notice: t('.success', badge: @test.title)
    else
      render :edit
    end
  end

  def update_inline
    if @test.update(test_params)
      redirect_to admin_tests_path, notice: t('.success')
    else
      render :index
    end
  end

  def destroy
    @test.destroy
    redirect_to admin_tests_path, notice: t('.success', badge: @test.title)
  end

  private

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :timer)
  end

  def find_test
    @test = Test.find(params[:id])
  end

  def set_tests
    @tests = Test.all
  end

  def rescue_with_test_not_found
    render inline: '<h1>Test not found [404]</h1>', status: 404
  end
end
