class Room < ApplicationRecord
  belongs_to :hotel
  validate :room_code
end