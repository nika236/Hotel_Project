class BookingsController < ApplicationController
  before_action :set_room, only: [:new, :create]

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = @room.bookings.build(booking_params)
    @booking.generate_booking_code
    if @booking.save
      flash[:notice] = "Your Book Created Successfully"
      redirect_to @booking
    else
      render 'new', status: :unprocessable_entity
    end

  end

  private
  def set_room
    @room = Room.find(params[:room_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date,:room_id,:count_price)
  end

end
