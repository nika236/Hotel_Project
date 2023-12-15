class HotelsController < ApplicationController
  before_action :set_hotel, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

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
    hotel_create = Hotels::HotelCreationService.new(hotel_params)
    begin
      if (hotel = hotel_create.create_hotel)
        flash[:notice] = "Hotel Created Successfully"
        redirect_to new_hotel_room_path(hotel.id)
      end
    rescue Hotels::HotelCreationError
      @hotel = hotel_create.hotel
      @hotel.valid?
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    hotel_update = Hotels::HotelUpdateService.new(@hotel, hotel_params)
    if hotel_update.update_hotel
      flash[:notice] = "Hotel's data updated successfully"
      redirect_to @hotel
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    hotel_destruction_service = Hotels::HotelDestructionService.new(@hotel)

    if hotel_destruction_service.destroy_hotel
      flash[:notice] = "Hotel deleted successfully"
      redirect_to hotels_path
    else
      flash[:alert] = "Failed to delete hotel"
      redirect_to @hotel
    end
  end

  private

  def set_hotel
    @hotel = Hotel.find(params[:id])
  end

  def hotel_params
    params.require(:hotel).permit(:name, :address, :description)
  end

end
