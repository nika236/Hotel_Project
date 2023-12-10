class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :user
  validates :start_date, presence: true
  validates :end_date, presence: true
  before_create :generate_booking_code
  before_validation :calculate_count_price
  validate :cant_be_in_past
  validate :end_date_after_start_date
  validate :no_overlapping_bookings



  def generate_booking_code
    loop do
      random_code = rand(10...100)
      new_code = "%02d" % random_code
      unless Booking.exists?(booking_code: new_code)
        self.booking_code = new_code
        break
      end
    end
  end

  def calculate_count_price
    return unless start_date.present? && end_date.present?
    self.count_price = room.price_per_night * (end_date.to_date - start_date.to_date).to_i
  end

  private

  def cant_be_in_past
    errors.add(:start_date, "can't be in the past") if start_date && start_date < Date.today
  end

  def end_date_after_start_date
    return unless start_date.present? && end_date.present?

    if end_date <= start_date
      errors.add(:end_date, "must be after the start date")
    end
  end

  def no_overlapping_bookings
    return unless start_date.present? && end_date.present?

    overlapping_bookings = room.bookings.where(
      "(start_date <= ? AND end_date >= ?) OR (start_date <= ? AND end_date >= ?) OR (start_date >= ? AND end_date <= ?)",
      end_date, start_date, start_date, end_date, start_date, end_date
    )


    if overlapping_bookings.exists?
      errors.add(:base, "Another booking exists for this room during the selected period")
    end
  end

end
