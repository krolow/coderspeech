class HomeController < ApplicationController
  def index
    @featured = Video.published.featured.order("RANDOM()").first
    @latest_videos = Video.published.recent.limit(8)
    @most_viewed_videos = Video.published.most_viewed.limit(8)
  end
end