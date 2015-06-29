class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_access
  before_action :set_user

  def show
  end

  def destroy
    @user.destroy
    redirect_to new_user_registration_path, notice: "User account has been deleted"
  end

  private
    def check_access
      redirect_to new_user_session_path unless params[:id] == current_user.id.to_s
    end

    def set_user
      @user = User.find(params[:id])
    end
end
