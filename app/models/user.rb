class User < ApplicationRecord
  has_many :adverts, dependent: :destroy
  has_many :comments, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, :country, :state, :city, :street, :zip, presence: true

  geocoded_by :address
  after_validation :geocode

  def address
    [street, city, state, country].compact.join(', ')
  end
end
