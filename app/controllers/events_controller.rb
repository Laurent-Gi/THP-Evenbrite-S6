class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :edit, :update]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end


  def create
    @event = Event.new(event_params)
    puts "="*80
    puts "Je suis dans le create events"
    puts params.inspect
    puts params.permit(:title, :description, :start_date, :duration, :price, :location).inspect

    @event.administrator = current_user
    puts "é"*80
    puts @event.inspect

    if @event.save
      flash[:success] = "Ton évènement a été créé avec succès !"
      puts "_"*80
      puts "SUCCES : "
      redirect_to event_path(@event.id)
    else
      puts "_"*80
      puts "ALERTE : "

      @alert = true
      @message = "Error: " + @event.errors.messages.to_a.flatten[1]
      render new_event_path
    end 
  end
  
  
  def update
    @event = Event.find(params[:id])
    if  @event.update(start_date: params[:start_date], duration: params[:duration], title: params[:title], description: params[:description], price: params[:price], location: params[:location])
    redirect_to event_path(@event.id)
    else
      flash[:warning] = "Nous n'avons pas pu modifier votre évènement"
      render edit_event_path(@event.id)
    end
  end


  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path
  end 


  private 
  def event_params
    params.permit(:title, :description, :start_date, :duration, :price, :location)
    # avec des formulaire de type form_for, on aurait plutôt besoin de ça :
    # params.require(:event).permit(:title, :description, :start_date, :duration, :price, :location)
  end 

end
