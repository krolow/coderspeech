class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_many :videos


  validates :name, presence: true, uniqueness: true
end