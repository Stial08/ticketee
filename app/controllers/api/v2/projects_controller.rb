class Api::V2::ProjectsController < Api::V2::BaseController

  before_filter :find_project, :only => [:show, :update]

  def index
    respond_with(Project.all.where('user_id = ?', current_user.id))
  end
  def create
    project = Project.new(params[:project])
    if project.save
      respond_with(project, :location => api_v1_project_path(project))
    else
      respond_with(project)
    end
  end
  def show
    respond_with(@project, :methods => "last_ticket")
  end

  def update
    @project.update_attributes(params[:project])
    respond_with(@project)
  end

  def destroy
    @project.destroy
    respond_with(@project)
  end

  private
  def find_project
    @project = Project.all.where('user_id = ?', current_user) 
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The project you were looking for could not be found."
    redirect_to projects_path
  end
end

