class ProjectsController < BaseController
  before_filter :build_project, :only => [:new, :create]
  load_and_authorize_resource

  def index
    @projects = current_user.applications
    respond_with(@projects)
  end
  
  def new
    respond_with(@project)
  end
  
  def create
    @project.save
    respond_with(@project)
  end
  
  def edit
    respond_with(@project)
  end
  
  def update
    @project.update_attributes(params[:project])
    respond_with(@project)
  end
  
  def destroy
    @project.destroy
    respond_with(@project, :location => projects_path)
  end
  
  protected
  
    def build_project
      @project = current_user.projects.new(params[:project])  
    end
end
