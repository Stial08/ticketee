class TicketsController < ApplicationController

  before_action :require_signin!, except: [:show, :index]
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

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

  def remove_tags

  end

  private
  def ticket_params
    params.require(:ticket).permit(:title, :description, :tag_names,
                                   assets_attributes: [:asset])
  end

  private
  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_ticket
    @ticket = @project.tickets.find(params[:id])
  end
end
