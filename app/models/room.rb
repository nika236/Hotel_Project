class Room < ApplicationRecord
  belongs_to :hotel
  has_many :bookings, dependent: :destroy
  validates :description, :price_per_night, presence: true
  validates :room_code, presence: true, uniqueness: true,
            format: { with: /\A\d+\z/, message: "should only contain numbers" }

end