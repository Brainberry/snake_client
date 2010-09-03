class ProjectsController < BaseController
  def index
    @projects = current_user.applications
    respond_with(@projects)
  end
  
  def new
    @project = current_user.projects.new
    respond_with(@project)
  end
end
