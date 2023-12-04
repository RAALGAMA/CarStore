class Province < ApplicationRecord
  has_many :users
  validates :name, :pst, :gst, :hst, presence: true
end
