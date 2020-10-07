module ApplicationHelper
  def current_year
    Time.zone.today.year
  end

  def github_url(name_link, author, repo)
    link_to name_link, "https://github.com/#{author}/#{repo}", target: :blank
  end

  def admin?
    current_user.is_a?(Admin)
  end
end
