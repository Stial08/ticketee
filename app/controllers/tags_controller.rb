class TagsController < ApplicationController
  def remove
    @ticket = Ticket.find(params[:ticket_id])
    @tag = Tag.find(params[:id])
    @ticket.tags -= [@tag] 
    @ticket.save
  end
end
