class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    return if @user = User.find_by(id: params[:id])

    flash[:danger] = t "not_found"
    redirect_to root_url
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash.now[:success] = t "welcome_sample_app"
      redirect_to @user
    else
      flash.now[:danger] = t "not_success"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
