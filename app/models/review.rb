class Review < ApplicationRecord
  belongs_to :house

  validates :content, presence: true
end
