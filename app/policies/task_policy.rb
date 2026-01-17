class TaskPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.manager?
        # Managers see tasks they created OR tasks assigned to them
        scope.where("creator_id = ? OR assigned_to_id = ?", user.id, user.id)
      else
        # Members only see tasks assigned to them
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
      # ✅ Managers can only edit tasks they created
      record.creator == user
    else
      false
    end
  end

  def destroy?
    if user.admin?
      true
    elsif user.manager?
      # ✅ Managers can only delete tasks they created
      record.creator == user
    else
      false
    end
  end

  def mark_complete?
    # Assigned member can mark complete, plus admins/managers
    record.assigned_to == user || user.admin? || user.manager?
  end
end
