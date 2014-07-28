class Video < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  acts_as_taggable_on :tags

  has_attached_file :image,
    :styles => {
      :medium => "458x266#",
      :thumb => "273x182#"
    }

  before_save :grab_video_info

  belongs_to :level
  belongs_to :category

  scope :recent, -> { order(date_of_video: :desc) }
  scope :most_viewed, -> { order(views: :desc) }
  scope :published, -> { where(published: true)}
  scope :featured, -> { where(featured: true)}
  scope :sort, -> sort {
    if sort == "date"
      order(date_of_video: :desc)
    end
    if sort == "popular"
      order(views: :desc)
    end

    order(created_at: :desc)
  }

  validates :title, presence: true, uniqueness: true
  validates :video, presence: true, url: true
  validates :slide, allow_blank: true, url: true
  validates :category, presence: true
  validates :image, presence: true
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/, message: "Image not valid"

  def view_grabber_working?
    @view_grabber_working
  end

  private
    def grab_video_info
      videoInfo = VideoInfo.new(self.video)
      logger.debug videoInfo.video_id
      self.embed_url = videoInfo.embed_url
      self.views = videoInfo.view_count
    end

end
