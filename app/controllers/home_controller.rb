class HomeController < ApplicationController
  def index
    @featured = Video.recent.featured.first
    @latest_videos = Video.published.recent.limit(6)
    @most_viewed_videos = Video.published.most_viewed.limit(6)
  end
end