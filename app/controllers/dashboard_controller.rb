class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @tasks =
      if current_user.admin?
        Task.order(due_date: :asc)
      elsif current_user.manager?
        Task.where(creator: current_user)
            .or(Task.where(assigned_to: current_user))
            .order(due_date: :asc)
      else
        Task.where(assigned_to: current_user).order(due_date: :asc)
      end
  end
end
