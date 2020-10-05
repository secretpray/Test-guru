module ApplicationHelper
  def current_year
    Time.zone.today.year
  end

  def github_url(name_link, author, repo)
    link_to name_link, "https://github.com/#{author}/#{repo}", target: :blank
  end

  def flash_message(flash)
    flash.map do |key, value|
      content_tag :p, value, class: "flash #{key}"
    end.join(' ').html_safe
  end
end
