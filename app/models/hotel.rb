class Hotel < ApplicationRecord
  has_many :rooms, dependent: :destroy
  validates :name, uniqueness: {case_sensitive: false} ,presence: true
  validates :address,uniqueness: {case_sensitive: false}, presence: true
  validates :description, presence: true

end
