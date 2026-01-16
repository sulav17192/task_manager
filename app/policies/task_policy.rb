class TaskPolicy < ApplicationPolicy
  def show?
    user_is_admin? || record.creator == user || record.assigned_to == user
  end

  def create?
    user_is_admin? || user&.manager?
  end

  def update?
    user_is_admin? || record.creator == user
  end

  def destroy?
    user_is_admin? || record.creator == user
  end

  def mark_complete?
    user_is_admin? || record.creator == user || record.assigned_to == user
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      return scope.all if user&.admin?
      scope.where(creator: user).or(scope.where(assigned_to: user))
    end
  end
end
