module Admin
  class UserPolicy < ApplicationPolicy
    def index?; user_is_admin?; end
    def show?; user_is_admin?; end
    def create?; user_is_admin?; end
    def update?; user_is_admin?; end
    def destroy?; user_is_admin?; end

    class Scope < Struct.new(:user, :scope)
      def resolve
        user&.admin? ? scope.all : scope.none
      end
    end
  end
end
