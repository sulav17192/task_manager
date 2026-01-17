class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[show edit update destroy mark_complete]

  def index
    @tasks = policy_scope(Task).order(due_date: :asc)
  end

  def show
    authorize @task
  end

  def new
    @task = Task.new
    authorize @task
  end

  def create
    @task = Task.new(task_params.merge(creator: current_user))
    authorize @task
    if @task.save
      TaskMailer.task_assigned(@task).deliver_later if @task.assigned_to.present?

      redirect_to @task, notice: "Task created successfully. Email notification queued."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @task
  end

  def update
    authorize @task
    if @task.update(task_params)
      redirect_to @task, notice: "Task updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @task
    @task.destroy
    redirect_to tasks_path, notice: "Task deleted."
  end

  def mark_complete
    authorize @task
    @task.update(status: :completed)
    redirect_to @task, notice: "Task marked complete."
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :assigned_to_id)
  end
end
