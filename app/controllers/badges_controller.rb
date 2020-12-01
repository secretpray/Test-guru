class BadgesController < ApplicationController

  def index
    @badges = Badge.all.sort_by(&:rule)
    @current_badges = current_user.badges.uniq.sort_by(&:rule)
  end

end
