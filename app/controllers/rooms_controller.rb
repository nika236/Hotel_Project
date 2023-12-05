class RoomsController < ApplicationController
  before_action :set_hotel, only: [:new, :create,:edit,:update, :destroy]
  before_action :set_room , only: [:edit, :update, :show, :destroy]
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
  def new
    @room = Room.new
  end

  def show
    @hotel = @room.hotel
  end

  def edit
  end

  def create
    @room = @hotel.rooms.build(room_params)
    if @room.save
      flash[:notice] = "Room created successfully"
      redirect_to @room.hotel
    else
      render 'new', status: :unprocessable_entity
    end

  end

  def update
    if @room.update(room_params)
      flash[:notice] = "Room's Detail successfully updated"
      redirect_to @room.hotel
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @room.destroy
    redirect_back  fallback_location: @room.hotel
  end

  private

  def room_params
    params.require(:room).permit(:room_code, :description, :price_per_night, :hotel_id)
  end

  def set_hotel
    @hotel = Hotel.find(params[:hotel_id])
  end
  def set_room
    @room = Room.find(params[:id])
  end

  def require_admin
    unless current_user && current_user.admin?
      redirect_to hotels_path, alert: "You must be an admin to access this page."
    end
  end
end
