class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :set_user_attended


  # GET /events or /events.json
  def index
    @events = Event.all
  end

  # GET /events/1 or /events/1.json
  def show
    # @event = Event.find_by(id: params[:id])
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @user_same_as_creator = @event.creator.id == current_user.id
    if !@user_same_as_creator
      flash[:notice] = "Denied, you are not the event creator!"
      redirect_to root_path
    end
  end

  # POST /events or /events.json
  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      flash.notice = "Event was successfully created."
      redirect_to @event
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @user_same_as_creator = @event.creator.id == current_user.id
    if !@user_same_as_creator
      flash[:notice] = "Denied, you are not the event creator!"
      redirect_to root_path
      return
    end

    @event.destroy!

    respond_to do |format|
      format.html { redirect_to events_path, status: :see_other, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def set_user_attended
      @user_joined_events = Set[]
      if user_signed_in?
        @user_joined_events = current_user
        .attended_events.map { |e| e.id }
        .to_set
      end
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :description, :date)
    end
end
