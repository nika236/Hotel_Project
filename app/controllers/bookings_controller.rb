class BookingsController < ApplicationController
  before_action :not_require_admin, only: [:new, :create]
  before_action :set_hotel, only: [:new, :create, :destroy, :show]
  before_action :set_room, only: [:new, :create, :destroy, :show]
  before_action :set_booking, except: [:new, :create]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found


  def show
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = @room.bookings.build(booking_params)
    @booking.user = current_user
    if @booking.save
      flash[:notice] = "Your Book Created Successfully"
      redirect_to hotel_room_booking_path(@hotel, @room, @booking)
    else
      render 'new', status: :unprocessable_entity
    end
  end


  def destroy
    @booking.destroy
    redirect_to hotel_room_path(@hotel, @room)
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_hotel
   @hotel = Hotel.find(params[:hotel_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :room_id, :count_price)
  end

end
