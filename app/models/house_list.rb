class HouseList < ApplicationRecord
  has_many :house_comparisons, dependent: destroy
  has_many :houses, through: :house_comparisons
  has_one_attached :photo

  validates :name, uniqueness: true
end
