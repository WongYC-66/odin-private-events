class UsersController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @events = @user.created_events
  end
end
