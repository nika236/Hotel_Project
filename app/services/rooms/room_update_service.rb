module Rooms
  class RoomUpdateService
    attr_reader :room
    def initialize(room, params)
      @room = room
      @params = params
    end

    def update_room
      if @room.update(@params)
        @room
      else
        false
      end
    end
  end
end