class AttendancesController < ApplicationController
  # Attendance relie un event et un user.
  before_action :authenticate_user!


  def index

    @event = Event.find(params[:event_id])
    @is_admin = current_is_admin?
    if !@is_admin
      flash[:alert] = "Seul un administrateur d'évènement peut avoir accès à cette page" 
      redirect_to root_path
    end
    #On sélectionne uniquement les attendances qui concernent notre événement
    @attendances_for_this_event = Attendance.where(event_id: @event.id)
    puts "="*80
    puts @attendances_for_this_event.inspect
    puts "="*80

  end

  def new
    flash[:alert] = "Cette fonctionnalité n'est pas utilisée - create avec le paiement"
    redirect_to root_path
  end

  def create
    flash[:alert] = "Cette fonctionnalité n'est pas utilisée - create avec le paiement"
    redirect_to root_path
  end

  def edit
  end

  def update

  end


  def destroy  # DELETE /events/:event_id/attendances/:id(.:format)         attendances#destroy

    # On récupère @event
    @event = Event.find(params[:event_id])
    # On récupère @attendance
    @attendance = Attendance.find(params[:id])


    if @is_participant = current_is_participant?
      @attendance.destroy
      # Attendance.destroy(params[:event_id],params[:id])
      # On peut rediriger vers l'évènement (il y aura un participant de moins et il ne sera plus participant)
      redirect_to event_path(params[:event_id]), notice: "Vous êtes à présent désincrit de cet évènement"
    else
      flash[:alert] = "Vous ne participez pas ou plus à l'évènement"
    end

  end


  private

  def current_is_admin?
    return true if current_user == @event.administrator
  end

  def current_is_participant?
    puts "="*80
    puts current_user.id
    puts @event.inspect
    puts @event.id
    puts "="*80
    list_attendances = Attendance.where(event_id: @event.id, user_id: current_user.id)
    # Si le tableau est vide, alors c'est que le current_user ne participe pas à l'événement en question
    return false if list_attendances == []
    return true
  end


  def event_chosen
    @event = Event.find(params[:event_id])
  end

  def find_event
    @event = Event.find(params[:event_id])
  end

  def find_attendance
    @attendance = @event.attendances.where(user_id: current_user.id)
  end

  def already_attendant?
    Attendance.where(user_id: current_user.id, event_id:params[:event_id]).exists?
  end


end





  # event_chosen
  # @not_admin = not_admin(@event)
  # #S'ils essaient de parvenir à la page index via URL, on les dégage
  # if @not_admin 
  #   redirect_to root_path
  #   flash[:alert] = "Tu fais nimp" 
  # end

  # #On sélectionne uniquement les attendances qui concernent notre événement
  # @all_attendances_for_this_event = Attendance.where(event_id: @event.id)

  # # def index
  #   @event = Event.find(params[:event_id])
  #   unless @event.administrator?(current_user)
  #     redirect_to @event, flash: { error: 'Tu ne peux voir les participants que des événements dont tu es administrateur !' }
  #   end
  # # end
######