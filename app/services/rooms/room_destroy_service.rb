module Rooms
  class RoomDestroyService
    attr_reader :room
    def initialize(room)
      @room = room

    end

    def destroy_room
      @room.destroy
    end
  end
end