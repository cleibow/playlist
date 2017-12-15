class Song < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes, source: :user
  validates :artist, :title, presence: true, length: { minimum: 2}
end
