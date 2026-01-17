class TaskPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin? || user.manager?
        scope.all
      else
        scope.where(assigned_to: user)
      end
    end
  end

  def show?
    user.admin? || user.manager? || record.assigned_to == user
  end

  def create?
    user.admin? || user.manager?
  end

  def update?
    user.admin? || user.manager? || record.assigned_to == user
  end

  def destroy?
    user.admin?
  end

  def mark_complete?
    record.assigned_to == user || user.admin? || user.manager?
  end
end
