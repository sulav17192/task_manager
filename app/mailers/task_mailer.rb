class TaskMailer < ApplicationMailer
  default from: "no-reply@taskmanager.com"

  def task_assigned(task)
    @task = task
    @user = task.assigned_to
    mail(to: @user.email, subject: "New Task Assigned: #{@task.title}")
  end
end
