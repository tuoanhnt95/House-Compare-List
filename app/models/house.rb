class House < ApplicationRecord
  has_many :reviews, dependent: destroy
  has_many :house_comparisons, dependent: destroy
  belongs_to :house_list
  validates :rent_fee, presence: true

  def initialize
    @name = "House #{this.id}"
  end
end
