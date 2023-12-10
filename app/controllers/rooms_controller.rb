class RoomsController < ApplicationController
  before_action :set_hotel, only: [:new, :create,:edit,:update, :destroy, :show]
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
    room_create = Rooms::RoomCreationService.new(@hotel, room_params)
    if (room = room_create.create_room)
      flash[:notice] = "Room created successfully"
      redirect_to hotel_room_path(@hotel, room.id)
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
    hotel_finder = Hotels::HotelFindByIdService.new(params[:hotel_id])
    @hotel = hotel_finder.find_hotel
    unless @hotel
      flash[:alert] = "There is No Recorded hotel"
      redirect_to root_path
    end
  end
  def set_room
    @room = Room.find(params[:id])

    unless @room
      flash[:alert] = "There is No Recorded Room"
      redirect_to root_path
    end
  end

end
