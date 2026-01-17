class ManagerMailer < ApplicationMailer
  default from: ENV["EMAIL_USER"]

  def invitation_email(manager, token)
    @manager = manager
    @token = token
    @accept_url = accept_manager_url(token: @token)
    mail(to: @manager.email, subject: "You're invited to be a Manager")
  end
end
