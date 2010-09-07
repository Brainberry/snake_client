class DashboardController < BaseController

  def index
    @applications = current_user.applications.order("updated_at DESC")
    respond_with(@applications)
  end
end
