class Hotel < ApplicationRecord
  has_many :rooms, dependent: :destroy
  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true

  # validate :must_have_at_least_one_room
  # private
  # def must_have_at_least_one_room
  #   errors.add(:base, 'Hotel must have at least one room') if rooms.empty?
  # end
end
