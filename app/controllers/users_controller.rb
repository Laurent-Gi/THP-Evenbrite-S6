class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show, :create, :edit, :update, :destroy]
  before_action :is_my_profile, only: [:show,:edit]

  # Pour l'instant
  # before_action :authenticate_user, only: [:show]
  # before_action :is_my_profile, only: [:show]

  def show
    @user = current_user
    # Liste des evenements de l'utilisateur ? à voir où le mettre ?
    # @user_events = Event.where(administrator_id: @user.id)
  end


  private

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in to perform this action."
      redirect_to :root
    end
  end

  def is_my_profile
    unless current_user == User.find(params[:id])
      flash[:danger] = "Tu ne peux pas accéder à ce compte"
      redirect_to :root
    end
  end

end
