class Province < ApplicationRecord
  has_many :users
  validates :name, :pst, :gst, :hst, presence: true
  validates :pst, :gst, :hst, numericality: true
end
