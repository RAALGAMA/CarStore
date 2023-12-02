class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :car
  validates :product_info, presence: true
end
