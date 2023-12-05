class Car < ApplicationRecord
  belongs_to :manufacturer
  has_one_attached :image
  validates :price, :year, :mileage, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :brand, :model, :title_status, :color, :vin, :lot, :state, :condition, presence: true
end
