class AddColumnFeaturedToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :featured, :boolean
  end
end
