class House < ApplicationRecord
  has_many :reviews
  belongs_to :house_list
  validates :rent_fee, presence: true

  def initialize
    @name = "House #{this.id}"
  end
end
