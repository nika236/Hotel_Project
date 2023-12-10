class BookingsController < ApplicationController
  before_action :not_require_admin, only: [:new, :create]
  before_action :set_hotel, only: [:new, :create, :destroy, :show]
  before_action :set_room, only: [:new, :create, :destroy, :show]
  before_action :set_booking, except: [:new, :create]

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
    @room = Room.find_by(id: params[:room_id])

    unless @room
      flash[:alert] = "There is No Recorded hotel"
      redirect_to root_path
    end
  end

  def set_hotel
    hotel_finder = Hotels::HotelFindByIdService.new(params[:hotel_id])
    @hotel = hotel_finder.find_hotel
    unless @hotel
      flash[:alert] = "There is No Recorded hotel"
      redirect_to root_path
    end
  end

  def set_booking
    @booking = Booking.find_by(id: params[:id])

    unless @booking
      flash[:alert] = "There is No Recorded hotel"
      redirect_to root_path
    end
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :room_id, :count_price)
  end

end
