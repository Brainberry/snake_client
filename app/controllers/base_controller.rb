class BaseController < ApplicationController
  layout "application"
  before_filter :authenticate_user!
  abstract!
  
  protected
  
    rescue_from CanCan::AccessDenied do |exception|
      flash[:error] = exception.message
      redirect_to root_url
    end
end
