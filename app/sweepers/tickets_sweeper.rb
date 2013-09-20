class TicketsSweeper < ActionController::Caching::Sweeper

  observe Ticket 
  def after_create(ticket)
    expire_fragment(/projects\/#{ticket.project.id}\/.*?/)
  end
  def after_update(ticket)
    expire_fragment(/projects\/#{ticket.project.id}\/.*?/)
  end
  def after_destroy(ticket)
    expire_fragment(/projects\/#{ticket.project.id}\/.*?/)
  end
end
