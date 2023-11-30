class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  validates :total_price, presence: true
end
