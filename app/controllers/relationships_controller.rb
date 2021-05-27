class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :find_user, only: :create
  before_action :find_relationship, only: :destroy

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to :js
  end

  def destroy
    current_user.unfollow(@user)
    respond_to :js
  end

  private
    def find_user
      @user = User.find_by(id: params[:followed_id])
      return if @user
      
      flash[:danger] = "User not found"
      redirect_to root_url

    end

    def find_relationship
      @user = Relationship.find_by(id: params[:id]).followed
      return if @user
      
      flash[:danger] = "You haven't followed this user yet"
      redirect_to :controller => "users", :action => "show", :id => current_user.id

    end
end
