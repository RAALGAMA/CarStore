class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :car
  validates :quantity, presence: true
end
