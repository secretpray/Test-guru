module ApplicationHelper
  def current_year
    Time.zone.today.year
  end

  def github_url(author, repo)
    "https://github.com/#{author}/#{repo}"
  end
end
