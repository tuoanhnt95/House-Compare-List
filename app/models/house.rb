class House < ApplicationRecord
  # has_many :reviews, dependent: destroy
  # has_many :house_comparisons, dependent: destroy
 # belongs_to :house_list, through: house_comparisons

  validates :rent_fee, numericality: { greater_than_or_equal_to: 0 }
  validates :mng_fee, numericality: { greater_than_or_equal_to: 0 }
  validates :lease_deposit, numericality: { greater_than_or_equal_to: 0 }
  validates :key_money, numericality: { greater_than_or_equal_to: 0 }
  validates :guarantee_deposit, numericality: { greater_than_or_equal_to: 0 }
  validates :floor_area, numericality: { greater_than: 0 }
  validates :station_distance_time, numericality: { greater_than: 0 }
  validates :built_year, numericality: { greater_than: 0 }
  validates :floor, numericality: { greater_than: 0 }
  validates :house_url, presence: true
end
