module Hotels
  class HotelCreationService
    def initialize(params)
      @params = params
    end

    def create_hotel
      hotel = Hotel.new(@params)
      if hotel.save
        hotel
      else
        false
      end

    end
  end
end