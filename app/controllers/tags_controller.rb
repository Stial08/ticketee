class TagsController < ApplicationController

 before_filter :authenticate_user! , except: [:show, :index]

  def remove
    @ticket = Ticket.find(params[:ticket_id])
    @tag = Tag.find(params[:id])
    @ticket.tags -= [@tag] 
    @ticket.save
  end
end
