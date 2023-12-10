module Rooms

  class RoomCreationService
    def initialize(hotel_id, params)
      @hotel_id = hotel_id
      @params = params
    end


    def create_room
      room = @hotel_id.rooms.build(@params)
      if room.save
        room
      else
        false
      end
    end

  end

end