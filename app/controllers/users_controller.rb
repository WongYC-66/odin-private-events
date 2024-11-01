class UsersController < ApplicationController
  def show
    begin
      @user = User.find(params[:user_id])
      @events = @user.created_events
    rescue ActiveRecord::RecordNotFound => e
      redirect_to "/404"
    end
  end
end
