class RoomsController < ApplicationController



  def new
    @room = Room.new
  end

  def edit
  end


  def create
    @room = Room.new(room_params)
    if @room.save
      flash[:notice] = "Room created successfully"
      redirect_to @room.hotel
    else
      render 'new', status: :unprocessable_entity
    end

  end

  def update
  end

  def destroy
    @room.destroy!

  end

  private
  def room_params
    params.require(:room).permit(:room_code, :description, :price, :hotel_id)
  end

end
