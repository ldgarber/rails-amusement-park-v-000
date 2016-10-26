class AttractionsController < ApplicationController 
  before_filter :verify_admin, only: [:new, :create, :edit, :update,  :destroy]

  def index
    @attractions = Attraction.all
  end

  def new
    @attraction = Attraction.new()
  end

  def create
    @attraction = Attraction.new(attraction_params)
    if @attraction.save
      redirect_to attraction_path(@attraction) 
    else
      flash[:error] = "Can't create attraction" 
      redirect_to attractions_path
    end
  end

  def show
    @attraction = Attraction.find(params[:id])
  end
  
  def edit
    @attraction = Attraction.find(params[:id])
  end

  def update
    @attraction = Attraction.find(params[:id])
    @attraction.update_attributes(attraction_params)
    if !@attraction.save
      flash[:error] = "Error, couldn't save changes"
    end
    redirect_to attraction_path(@attraction)
  end

  def destroy
  end

  private
  def attraction_params
    params.require(:attraction).permit(:name, :min_height, :happiness_rating, :nausea_rating, :tickets)
  end

  def verify_admin
    redirect_to root_path unless current_user.admin? 
  end
end
