class ApplicationController < ActionController::Base
  protect_from_forgery
  layout "default"
  respond_to :html, :xml, :json
end
