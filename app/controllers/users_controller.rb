class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :load_user, only: %i(update show edit)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def index
    @users = User.page(params[:page]).per Settings.user_pages
  end

  def show; end

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

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "profile_updated"
      redirect_to @user
    else
      flash[:danger] = t "not_success"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user_deleted"
    else
      flash[:danger] = t "user_not_deleted"
    end
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email,
                                 :password, :password_confirmation
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "please_log_in"
    redirect_to login_url
  end

  def correct_user
    redirect_to(root_url) unless current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "not_found"
    redirect_to root_url
  end
end
