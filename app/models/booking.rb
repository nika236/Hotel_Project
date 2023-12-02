class Booking < ApplicationRecord
  belongs_to :room
  validates :start_date, :end_date, :count_price, presence: true
  before_validation :generate_booking_code, on: :create
  before_validation :calculate_count_price

  def generate_booking_code
    random_code = rand(10...100)
    self.booking_code = "%02d" % random_code
  end
  def calculate_count_price
    self.count_price = room.price_per_night * (end_date.to_date - start_date.to_date).to_i
  end

end
