class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user &.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == Settings.readme ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:danger] = t "invalid_email_or_password_comnination"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
