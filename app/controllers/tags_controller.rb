class TagsController < ApplicationController
  def remove
    @ticket = Ticket.find(params[:ticket_id])
    @tag = Tag.find(params[:id])
    @ticket.tags -= [@tag] <co id="ch11_409_1"/>
    @ticket.save
    render :nothing => true
  end
end
