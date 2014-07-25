class Video < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  acts_as_taggable_on :tags

  has_attached_file :image,
    :styles => {
      :medium => "458x266#",
      :thumb => "273x182#"
    }

  belongs_to :level
  belongs_to :category

  scope :recent, -> { order(date: :desc) }
  scope :most_viewed, -> { order(views: :desc) }
  scope :published, -> { where(published: true)}
  scope :featured, -> { where(featured: true)}

  validates :title, presence: true, uniqueness: true
  validates :video, presence: true, url: true
  validates :slide, allow_blank: true, url: true
  validates :category, presence: true
  validates :image, presence: true
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/, message: "Image not valid"

end
