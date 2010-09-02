class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_by_resource
  
  protected
  
    rescue_from CanCan::AccessDenied do |exception|
      flash[:error] = exception.message
      redirect_to root_url
    end
    
    def layout_by_resource
      if devise_controller? && resource_name == :user
        "default"
      else
        "application"
      end
    end
end
