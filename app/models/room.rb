class Room < ApplicationRecord
  belongs_to :hotel
  has_many :bookings, dependent: :destroy
  validates :description, :price_per_night, presence: true
  validates :room_code, presence: true, uniqueness: true,
            format: { with: /\A\d+\z/, message: "should only contain numbers" }
  validate :price_more_than_zero

  def price_more_than_zero
    return unless price_per_night.present?
    errors.add(:price_per_night, "can't be less than zero") if price_per_night < 0
  end

end