class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def smo_prerender
    @package = Package.published.find_by!(name: params[:path]).decorate
  end
end
