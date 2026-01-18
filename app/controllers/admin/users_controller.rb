module Admin
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: %i[show edit update destroy]

    def index
      authorize [:admin, User]

      if params[:query].present?
        @users = User.where("email LIKE ?", "%#{params[:query]}%").order(created_at: :desc)
      else
        @users = User.order(created_at: :desc)
      end
    end

    def show
      authorize [:admin, @user]
    end

    def new
      @user = User.new
      authorize [:admin, @user]
    end

    def create
      @user = User.new(user_params)
      authorize [:admin, @user]
      if @user.save
        redirect_to admin_users_path, notice: "User created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      authorize [:admin, @user]
    end

    def update
      authorize [:admin, @user]
      if @user.update(user_params)
        redirect_to admin_users_path, notice: "User updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize [:admin, @user]
      @user.destroy
      redirect_to admin_users_path, notice: "User deleted."
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :role)
    end
  end
end
