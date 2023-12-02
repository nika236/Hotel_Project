class Room < ApplicationRecord
  belongs_to :hotel
  has_many :bookings
  validates :room_code, :description, :price_per_night, presence: true
end