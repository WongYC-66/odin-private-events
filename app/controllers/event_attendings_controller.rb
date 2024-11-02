class EventAttendingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_attended

  def create
    @event = Event.find(params[:event_id])
    if !@user_joined_events.include?(@event.id)
      @event.attendees << current_user
    end
    redirect_to @event
  end

  def destroy
    @event = Event.find(params[:event_id])
    if @user_joined_events.include?(@event.id)
      @event.attendees.delete(current_user)
    end
    redirect_to @event
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
