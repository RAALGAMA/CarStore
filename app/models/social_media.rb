class SocialMedia < ApplicationRecord
  belongs_to :manufacturer
  validates :twitter, :facebook, :instagram, presence: true
end
