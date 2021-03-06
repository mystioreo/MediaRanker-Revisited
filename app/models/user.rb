class User < ApplicationRecord
  has_many :votes
  has_many :ranked_works, through: :votes, source: :work
  has_many :works, dependent: :nullify

  validates :username, uniqueness: true, presence: true

  def self.build_from_github(auth_hash)
   user = User.new
   user.uid = auth_hash[:uid]
   user.provider = auth_hash[:provider]
   user.username = auth_hash['info']['name']

   # Note that the user has not been saved
   return user
  end
end
