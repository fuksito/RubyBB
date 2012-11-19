class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :update_current_user, :if => :current_user

  def update_current_user
    current_user.touch
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
end
