class TestPassagesController < ApplicationController

  before_action :set_test_passage, only: %i[show result update gist]

  def show
    redirect_to tests_path, alert: t('.empty_tests') unless @test_passage.test.questions.any?
  end

  def result
    send_result_to_email
  end

  def update 
    @test_passage.accept!(params[:answer_ids]) if params[:answer_ids]

    if @test_passage.completed? || check_timer
      if @test_passage.success?
        # send_result_to_email

        flash_options = BadgeService.new(@test_passage).call
      end

      flash_options ||= {}
      redirect_to result_test_passage_path(@test_passage, badges: @rules_array), flash_options
    else
      render :show
    end
  end

  def gist
    service = GistQuestionService.new(@test_passage.current_question)
    result = service.call

    flash_options = create_gist!(service, result)

    redirect_to @test_passage, flash_options
  end

  private

  def create_gist!(service, result)
    if service.success?
      gist_url = result.html_url

      current_user.gists.create(question: @test_passage.current_question, gist_url: gist_url)
      { safe_notice: t('.success', gist_url: gist_url) }
    else
      { alert: t('.failure') }
    end
  end

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def send_result_to_email
    unless @test_passage.completed
      @test_passage.update(completed: true)
      TestsMailer.completed_test(@test_passage).deliver_now
    end
 end

  def check_timer
    @test_passage.test.present? && @test_passage.time_over?
  end

end
