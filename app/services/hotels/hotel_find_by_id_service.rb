module Hotels
  class HotelFindByIdService
    def initialize(hotel_id)
      @hotel_id = hotel_id
    end

    def find_hotel
      Hotel.find_by(id: @hotel_id)
    end
  end
end