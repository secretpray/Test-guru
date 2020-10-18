class Admin::GistsController < Admin::BaseController
  def index
    @gists = Gist.order("id DESC").all
  end
end
