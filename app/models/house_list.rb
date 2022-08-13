class HouseList < ApplicationRecord
  has_many :house_comparisons, dependent: :destroy
  has_many :houses, through: :house_comparisons
  has_one_attached :photo

  validates :name, presence: true, uniqueness: true
  validates :total_price, numericality: { greater_than_or_equal_to: 0 }
  validates :floor_area, numericality: { greater_than_or_equal_to: 0 }
  validates :station_distance_time, numericality: { greater_than_or_equal_to: 0 }
  validates :built_year, numericality: { greater_than_or_equal_to: 0 }
  validates :floor, numericality: { greater_than_or_equal_to: 0 }

  attribute :total_price, default: 1
  attribute :floor_area, default: 1
  attribute :station_distance_time, default: 1
  attribute :built_year, default: 1
  attribute :floor, default: 1
end
