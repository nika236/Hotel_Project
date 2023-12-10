module Hotels
  class HotelUpdateService

    def initialize(hotel, params)
      @hotel = hotel
      @params = params
    end

    def update_hotel
      if @hotel.update(@params)
        @hotel
      else
        false
      end

    end


  end
end