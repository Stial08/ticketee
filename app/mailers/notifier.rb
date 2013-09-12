class Notifier < ActionMailer::Base
  default from: "stial08@gmail.com"

  def comment_updated(comment, user)
    @comment = comment
    @user = user
    @ticket = comment.ticket
    @project = @ticket.project
    subject = "[ticketee] #{@project.name} - #{@ticket.title}"
    mail(:to => user.email, :subject => subject)
  end
end
