class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.admin? || current_user.manager?
      @tasks = Task.all
      @total_tasks = @tasks.count
      @completed_tasks = @tasks.completed.count
      @pending_tasks = @tasks.pending.count
      @overdue_tasks = @tasks.where("due_date < ?", Date.today).count
    else
      @tasks = Task.where(assigned_to: current_user)
      @total_tasks = @tasks.count
      @completed_tasks = @tasks.completed.count
      @pending_tasks = @tasks.pending.count
      @overdue_tasks = @tasks.where("due_date < ?", Date.today).count
    end
  end
end
