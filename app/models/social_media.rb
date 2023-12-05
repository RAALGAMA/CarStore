class SocialMedia < ApplicationRecord
  belongs_to :manufacturer
  validates :twitter, :facebook, :youtube, :instagram, presence: true

end
