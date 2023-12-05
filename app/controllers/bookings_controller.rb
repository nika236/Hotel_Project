class BookingsController < ApplicationController
  before_action :set_room, only: [:new, :create, :destroy]
  before_action :set_hotel, only: [:new, :create, :destroy]
  before_action :set_booking, except: [:new, :create]
  before_action :not_require_admin, only: [:new, :create]

  def show
    @hotel = @booking.room.hotel
    @room = @booking.room
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = @room.bookings.build(booking_params)
    @booking.user = current_user
    @booking.generate_booking_code
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
  def not_require_admin
    if current_user && current_user.admin?
      redirect_to hotels_path, alert: "admin can't access this page."
    end
  end
end
