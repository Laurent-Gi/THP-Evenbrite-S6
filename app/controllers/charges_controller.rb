class ChargesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    # Ce new est pour participer à un évènement // dans charge car lié à un paiment mais... bon.
    @event = Event.find(params[:event_id])
    @attendance = Attendance.new
    # Amount in cents
    @amount = @event.price*100  # en centimes 
    # On va dans le formulaire de new.html.erb : s'incrire à l'évènement et régler la somme due !
  end



  def create
    @event = Event.find(params[:event_id])
    # Amount in cents
    @amount = @event.price*100  # en centimes 
    @user = current_user

    puts "#{@user.email} cherchez à créer votre participation à l'évènement #{@event.id} qui coute #{@event.price}"

    # Création d'un objet Stripe : Customer (Que l'on pourrait recherche la fois suivante grâce au custumer.id généré)
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: "Paiement de #{@user.email}",
      currency: 'eur',
    })

    # S'il n'y a pas eu d'erreur, création de l'attendance pour cet user et cet event
    attendance = Attendance.create(event: @event, user: current_user, stripe_customer_id: customer.id)

    if attendance
      # event#show (on montre l'évènement à nouveau... il devient participant et ça change la vue)
      redirect_to event_path(@event.id), flash: { success: 'Merci pour ton inscription !' }
    else
      flash[:error] = "Votre participation n'a pas pu aboutir !"
      redirect_to new_charge_path
    end

    # puts "Pour l'instant"
    # redirect_to event_path(@event.id) # Page de event#show  pour mes tests

    # Les erreurs sont traitées par le rescue ! problème de Stripe ici
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_event_charge_path(@event.id)
  end

end
