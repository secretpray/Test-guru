module ApplicationHelper

  FLASH_NAME = {  :success => 'alert-success', :error => 'alert-danger',
                  :alert => 'alert-warning', :notice => 'alert-info', :safe_notice => 'alert-primary' }

  def current_year
    Time.zone.today.year
  end

  def github_url(name_link, author, repo)
    link_to name_link, "https://github.com/#{author}/#{repo}", target: :blank, class: "btn-link-custom"
  end

  def button_select(obj)
    obj.new_record? ? t('.create') : t('.update')
  end

  def bootstrap_class_for_flash(flash_type)
    flash = FLASH_NAME[flash_type.to_sym] || flash_type.to_s
  end

  def svg(name)
    file_path = "#{Rails.root}/app/assets/images/#{name}.svg"
    return File.read(file_path).html_safe if File.exists?(file_path)

    '(not found)'
  end

end
