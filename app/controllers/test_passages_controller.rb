class TestPassagesController < ApplicationController

  before_action :set_test_passage, only: %i[show result update gist]
  before_action :set_users_badge, only: :update

  def show
    redirect_to tests_path, alert: t('.empty_tests') unless @test_passage.test.questions.any?
  end

  def result
    @badges = Badge.where(rule: params[:badges]) if @test_passage.success?
  end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      if @test_passage.success?
        @test_passage.update(completed: true)
        @rules_array = @users_badge.check_all_rules(current_user, @test_passage.test_id.to_i)
        current_user.badges.push(Badge.where(rule:[@rules_array]))
      end

      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage, badges: @rules_array)
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

  def set_users_badge
     @users_badge = UsersBadge.new
  end
end

