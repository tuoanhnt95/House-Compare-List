class HouseList < ApplicationRecord
  has_many :houses
  has_one_attached :photo

  validates :name, uniqueness: true
end
