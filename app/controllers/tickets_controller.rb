class TicketsController < ApplicationController

  
 before_filter :authenticate_user! , except: [:show, :index]
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  #after_create :creator_watches_me

  def new
    @project = Project.find(params[:project_id])
    @ticket = @project.tickets.build
    3.times { @ticket.assets.build }
    #@ticket = Ticket.new(:project_id => @project.id)
  end

  def create
    @project = Project.find(params[:project_id])
    @ticket = @project.tickets.build(ticket_params)
    @ticket.user = current_user
    if @ticket.save
      flash[:notice] = "Ticket has been created."
      redirect_to [@project, @ticket]
    else
      flash[:alert] = "Ticket has not been created."
      render :action => "new"
    end
  end

  def show
    @ticket = Ticket.find(params[:id])
    @comment = @ticket.comments.build
    @states = State.all
  end

  def edit
  end
  
  def update
    if @ticket.update(ticket_params)
      ticket.user = user
      ticket.save
      flash[:notice] = "Ticket has been updated."
      redirect_to [@project, @ticket]
    else
      flash[:alert] = "Ticket has not been updated."
      render action: "edit"
    end
  end

  def destroy
    @ticket.destroy
    flash[:notice] = "Ticket has been deleted."
    redirect_to @project
  end

  def search
    @project = Project.find(params[:project_id])
    @tickets = @project.tickets.search("tag:#{params[:search]}")
    render "projects/show"
  end

  def watch
    @project = Project.find(params[:project_id])
    @ticket = @project.tickets.find(params[:id])
    if @ticket.watchers.exists?(current_user)
      @ticket.watchers -= [current_user]
      flash[:notice] = "You are no longer watching this ticket."
    else
      @ticket.watchers << current_user
      flash[:notice] = "You are now watching this ticket."
    end
    redirect_to project_ticket_path(@ticket.project, @ticket)
  end

  private
  def ticket_params
    params.require(:ticket).permit(:title, :description, :tag_names,
                                   assets_attributes: [:asset])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_ticket
    @ticket = @project.tickets.find(params[:id])
  end

  def creator_watches_me
    if user
      self.watchers << user unless self.watchers.include?(user)
    end
  end
end
