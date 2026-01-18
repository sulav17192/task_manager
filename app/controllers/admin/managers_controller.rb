module Admin
  class ManagersController < ApplicationController
    before_action :authenticate_user! 
    before_action :ensure_admin!       

    def new_invite
    end

    def invite_manager
      @manager = User.new(email: params[:email], role: :manager)
      token = SecureRandom.hex(20)
      @manager.invitation_token = token
      @manager.save!

      ManagerMailer.invitation_email(@manager, token).deliver_later
      redirect_to admin_dashboard_path, notice: "Invitation email sent to #{@manager.email}"
    end

    private

    def ensure_admin!
      unless current_user&.role == "admin"
        redirect_to root_path, alert: "You are not authorized to access this page."
      end
    end
  end
end
