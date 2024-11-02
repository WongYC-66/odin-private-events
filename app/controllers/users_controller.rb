class UsersController < ApplicationController
  before_action :set_user_attended

  def show
    begin
      @user = User.find(params[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to "/404"
    end
  end

  private
    def set_user_attended
      @user_joined_events = Set[]
      if user_signed_in?
        @user_joined_events = current_user
        .attended_events.map { |e| e.id }
        .to_set
      end
    end
end
