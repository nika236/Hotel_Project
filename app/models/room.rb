class Room < ApplicationRecord
  belongs_to :hotel
  validates :room_code, :description, :price, presence: true
end