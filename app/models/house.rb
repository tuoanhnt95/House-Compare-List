# require 'open-uri'
# require 'nokogiri'

class House < ApplicationRecord

  has_many :reviews, dependent: :destroy
  has_many :house_comparisons, dependent: :destroy
  # belongs_to :house_list, through: :house_comparisons

  validates :house_url, presence: true
  validates :rent_fee, numericality: { greater_than_or_equal_to: 0 }
  validates :mng_fee, numericality: { greater_than_or_equal_to: 0 }
  validates :lease_deposit, numericality: { greater_than_or_equal_to: 0 }
  validates :key_money, numericality: { greater_than_or_equal_to: 0 }
  validates :guarantee_deposit, numericality: { greater_than_or_equal_to: 0 }
  validates :floor_area, numericality: { greater_than: 0 }
  validates :station_distance_time, numericality: { greater_than: 0 }
  validates :built_year, numericality: { greater_than: 0 }
  validates :floor, numericality: { greater_than: 0 }

  after_initialize :init

  def init
    self.rent_fee ||= 0
    self.mng_fee ||= 0
    self.lease_deposit ||= 0
    self.key_money ||= 0
    self.guarantee_deposit ||= 0
    self.floor_area ||= 1
    self.station_distance_time ||= 1
    self.built_year ||= 1970
    self.floor ||= 1
  end
end
