class Car < ApplicationRecord
  belongs_to :manufacturer
  has_one_attached :image
end
