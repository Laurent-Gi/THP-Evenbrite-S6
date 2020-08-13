class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :is_my_profile, only: [:show]


  def show
    @user = current_user
    # Liste des evenements de l'utilisateur ? à voir où le mettre ?
    # @user_events = Event.where(administrator_id: @user.id)
  end


  private

  def is_my_profile
    unless current_user == User.find(params[:id])
      flash[:danger] = "Tu ne peux accéder qu'aux information de ton compte"
      redirect_to :root
    end
  end

end
