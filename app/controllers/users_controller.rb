class UsersController < ApplicationController
  before_filter :auth_user, only: [:show]

  def index 
    @users = User.all
  end 

  def create
    session[:user_id] = current_user.id
  end 

  def show
    @user = User.find(params[:id])
  end

  def update 
    @user = current_user 
    if params[:attraction_id]
      @attraction = Attraction.find(params[:attraction_id])
      @ride = Ride.find_or_create_by_user_and_attraction(@user, @attraction)
      flash[:message] = @ride.take_ride
    end
    redirect_to user_path(@user)
  end

  private
  def auth_user
    redirect_to root_path unless user_signed_in? 
  end

end
