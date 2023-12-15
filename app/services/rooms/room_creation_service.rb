module Rooms

  class RoomCreationService
    attr_reader :room
    def initialize(hotel, params)
      @hotel = hotel
      @params = params
    end


    def create_room
      @room = @hotel.rooms.build(@params)
      if @room.save
        @room
      else
        false
      end
    end

  end

end