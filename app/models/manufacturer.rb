class Manufacturer < ApplicationRecord
  has_many :cars, dependent: :destroy
  has_one  :social_media, dependent: :destroy
  validates :name, :site, presence: true
end
