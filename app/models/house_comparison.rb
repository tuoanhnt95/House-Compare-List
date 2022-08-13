class HouseComparison < ApplicationRecord
  belongs_to :house
  belongs_to :house_list

  validates :comment, presence: true
end
