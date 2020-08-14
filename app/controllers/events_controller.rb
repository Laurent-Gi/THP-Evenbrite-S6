class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :edit, :update]


  def index
    @events = Event.all
  end


  def show
    @event = Event.find(params[:id])
    @is_admin = current_is_admin?
    @is_participant = current_is_participant?
  end


  def new
    @event = Event.new
  end


  def edit
    @event = Event.find(params[:id])
  end


  def create
    @event = Event.new(event_params)
    puts params.permit(:title, :description, :start_date, :duration, :price, :location).inspect
    @event.administrator = current_user
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
    if  @event.update(event_params2)
    redirect_to event_path(@event.id)
    else
      flash[:warning] = "Nous n'avons pas pu modifier votre événement"
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

  # Désolé mais mes formulaires ne sont pas homogènes alors j'ai 2 façon de retraiter les params pour que ça fonctionne
  def event_params2
    @event_params = params.require(:event).permit(:title, :description, :start_date, :duration, :price, :location) 
  end

  #Trouver la date de fin de l'événement / Je ne vois pas l'intérêt ici mais c'est dans le projet
  def end_date(event)
    @end_date = event.start_date + event.duration
    return @end_date
  end  


  def current_is_admin?
    return true if current_user == @event.administrator
  end


  def current_is_participant?
    list_attendances = Attendance.where(event_id: @event.id, user_id: current_user.id)
    # Si le tableau est vide, alors c'est que le current_user ne participe pas à l'événement en question
    return false if list_attendances == []
    return true
  end


end
