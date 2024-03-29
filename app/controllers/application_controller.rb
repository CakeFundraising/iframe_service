class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :allow_iframe

  private

  def allow_iframe
    response.headers.except! 'X-Frame-Options'  
  end
end
