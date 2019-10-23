class UsersController < ApplicationController
  def show
    return if @user = User.find_by(id: params[:id])

    flash[:danger] = t "not_found"
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
