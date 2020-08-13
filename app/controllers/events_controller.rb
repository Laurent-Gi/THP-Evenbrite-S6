class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.administrator_id = current_user.id

    if @event.save
      flash[:success] = "The event was succesfully created !"
      redirect_to event_path(@event.id)
    else
      @alert = true
      @message = "Error: " + @event.errors.messages.to_a.flatten[1]
      render new_event_path
    end 
  end
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path
  end 

  private 
  def event_params
    params.require(:event).permit(:title, :description, :start_date, :duration, :price, :location)
  end 

end
