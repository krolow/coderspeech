class AddColumnEmbedUrlAndViewGrabberWorkingToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :embed_url, :string
    add_column :videos, :view_grabber_working, :boolean
  end
end
