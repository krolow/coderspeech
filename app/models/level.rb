class Level < ActiveRecord::Base
  has_many :videos

  validates :name, presence: true, uniqueness: true
end
