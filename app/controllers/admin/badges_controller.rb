class Admin::BadgesController < Admin::BaseController
  before_action :set_badge, only: %i[show edit update destroy]
  before_action :set_badges, only: :index

  def show; end

  def new
    @badge = Badge.new
  end

  def edit; end

  def create
    @badge = Badge.new(badge_params)
    if @badge.save
      redirect_to [:admin, @badge], notice: t('admin.tests.create.success', badge: @badge.title)
    else
      flash[:notice] = t('.badges.not_success', badge: @badge.title)
      render :new
    end
  end

  def update
    if @badge.update(badge_params)
      redirect_to [:admin, @badge], notice: t('admin.tests.update.success', badge: @badge.title)
    else
      flash[:notice] = t('admin.tests.update.not_success', badge: @badge.title)
      render :edit
    end
  end

  def destroy
    @badge.destroy
    redirect_to admin_badges_path, notice: t('admin.tests.destroy.success', badge: @badge.title)
  end

  private

  def set_badge
    @badge = Badge.find(params[:id])
  end

  def set_badges
    @badges = Badge.all
  end

  def badge_params
    params.require(:badge).permit(:title, :image, :rule)
  end
end
