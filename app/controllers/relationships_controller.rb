class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_user_followed, only: :create
  before_action :relationship_user, only: :destroy

  def create
    current_user.follow @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    current_user.unfollow @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  private

  def load_user_followed
    @user = User.find_by id: params[:followed_id]
    return if @user

    flash[:danger] = t "not_found"
    redirect_to root_url
  end

  def relationship_user
    @user = Relationship.find_by(id: params[:id]).followed
    return if @user

    flash[:danger] = t "not_found"
    redirect_to root_url
  end
end
