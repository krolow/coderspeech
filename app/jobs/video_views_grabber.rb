class VideoViewsGrabberJob
  @queue = :videos_view_queue

  def self.perform(video_id)
    video = Video.find(video_id)
    video.views_grabber_working = true
    video.save

    videoInfo = VideoInfo.new(video.url)
    video.views = videoInfo.view_count
  end
end