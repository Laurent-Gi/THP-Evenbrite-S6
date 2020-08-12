class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show,:create,:edit,:update,:create,:destroy]
  before_action :is_my_profile, only: [:show,:edit]

  def show
    @user = User.find(params[:id])
    @events = Event.all
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