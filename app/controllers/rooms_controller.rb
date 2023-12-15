class RoomsController < ApplicationController
  before_action :set_hotel, only: [:new, :create,:edit,:update, :destroy, :show]
  before_action :set_room , only: [:edit, :update, :show, :destroy]
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def new
    @room = Room.new
  end

  def show
    @hotel = @room.hotel
  end

  def edit
  end

  def create
    room_create = Rooms::RoomCreationService.new(@hotel, room_params)
    if room_create.create_room
      flash[:notice] = "Room created successfully"
      redirect_to hotel_room_path(@hotel, room_create.room)
    else
      @room = room_create.room
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    room_update = Rooms::RoomUpdateService.new(@room , room_params)
    if room_update.update_room
      flash[:notice] = "Room's Detail successfully updated"
      redirect_to room_update.room.hotel
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    room_destroy = Rooms::RoomDestroyService.new(@room)
    if room_destroy.destroy_room
      flash[:notice] = "Room Deleted Successfully"
      redirect_to room_destroy.room.hotel
    else
      flash[:alert] = "Falied to Delete Room"
      redirect_to room_destroy.room
    end
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

end
