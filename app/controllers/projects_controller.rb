class ProjectsController < ApplicationController

  before_filter :authenticate_user!

  caches_action :show, :cache_path => (proc do 
    project_path(project_path(params[:id]) +"/#{current_user.id}/#{params[:page] || 1}")
  end)

  #before_action :authorize_admin!, except: [:index, :show]
  before_action :set_project, only: [:show,
                                     :edit,
                                     :update,
                                     :destroy]
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    if @project.save
      flash[:notice] = "Project has been created."
      redirect_to @project
    else
      flash[:alert] = "Project has not been created."
      render :action => "new"
    end
  end

  def show
    @tickets = @project.tickets
    @tickets = @tickets.page(params[:page]).per(5)
  end

  def edit
  end


  def update
    if @project.update(project_params)
      flash[:notice] = "Project has been updated."
      redirect_to @project
    else
      flash[:alert] = "Project has not been updated."
      render action: "edit"
    end
  end

  def destroy
    @project.destroy
    flash[:notice] = "Project has been destroyed."
    redirect_to projects_path
  end

  private
  def project_params
    params.require(:project).permit(:name, :description)
  end

  private
  def set_project
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The project you were looking" +
      " for could not be found."
    redirect_to projects_path
  end
end
