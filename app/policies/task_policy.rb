class TaskPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.manager?
        scope.where("creator_id = ? OR assigned_to_id = ?", user.id, user.id)
      else
        scope.where(assigned_to_id: user.id)
      end
    end
  end

  def show?
    user.admin? || record.creator == user || record.assigned_to == user
  end

  def create?
    user.admin? || user.manager?
  end

  def update?
    if user.admin?
      true
    elsif user.manager?
      record.creator == user
    else
      false
    end
  end

  def destroy?
    if user.admin?
      true
    elsif user.manager?
      record.creator == user
    else
      false
    end
  end

  def mark_complete?
    record.assigned_to == user || user.admin? || user.manager?
  end
end
