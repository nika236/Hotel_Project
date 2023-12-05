class HotelsController < ApplicationController
  before_action :set_hotel, only: [ :show, :edit, :update,:destroy ]
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
  def index
    @hotels = Hotel.all
  end

  def show
  end

  def new
    @hotel = Hotel.new
  end

  def edit
  end

  def create
    @hotel = Hotel.new(hotel_params)
    if @hotel.save
      flash[:notice] = "Hotel Created successfully"
      redirect_to @hotel
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    if @hotel.update(hotel_params)
      flash[:notice] = "Hotel's data updated successfully"
      redirect_to @hotel
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @hotel.destroy
    redirect_to hotels_path
  end

  private

  def set_hotel
    @hotel = Hotel.find(params[:id])
  end

  def hotel_params
    params.require(:hotel).permit(:name, :address, :description)
  end

  def require_admin
    unless current_user && current_user.admin?
      redirect_to hotels_path, alert: "You must be an admin to access this page."
    end
  end
end
