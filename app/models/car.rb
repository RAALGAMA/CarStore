class Car < ApplicationRecord
  belongs_to :manufacturer
  has_one_attached :image
  has_many :order_items

  validates :quantity, presence: true
  validates :brand, presence: true
  validates :model, presence: true
end
