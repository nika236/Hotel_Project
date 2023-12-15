module Hotels
  class HotelCreationError < StandardError
  end

  class HotelCreationService
    attr_reader :hotel

    def initialize(params)
      @params = params
    end

    def create_hotel
      @hotel = Hotel.new(@params)
      if @hotel.save
        @hotel
      else
        raise HotelCreationError, "Failed to create hotel: #{validation_errors}"
      end
    end

    private
    def validation_errors
      @hotel.errors.full_messages.join(', ')
    end
  end
end
