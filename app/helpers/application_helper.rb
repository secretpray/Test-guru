module ApplicationHelper
  def current_year
    Time.zone.today.year
  end

  def github_url(name_link, author, repo)
    link_to name_link, "https://github.com/#{author}/#{repo}", target: :blank
  end

  # language indicator (return string or link if conditions)
  # variant 1 (not used in now)
  # def language_link(lang, url)
  #   if I18n.locale != lang.to_sym
  #     return link_to lang, url
  #   else
  #     return lang
  #   end
  # end

  # button name select in many view
  def button_select(obj)
    obj.new_record? ? t('.create') : t('.update')
  end

  # refactoring code for flash in Bootstrap 4+
  def bootstrap_class_for_flash(flash_type)
    case flash_type
    when 'success'
      'alert-success'
    when 'error'
      'alert-danger'
    when 'alert'
      'alert-warning'
    when 'notice'
      'alert-info'
    else
      flash_type.to_s
    end
  end
end
