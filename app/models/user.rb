class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :bookings, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: [:user, :admin]
  # validates :username, uniqueness: true, length: {minimum: 7}
  after_initialize :set_default_role, if: :new_record?
  def set_default_role
    self.role ||= :user
  end
end
