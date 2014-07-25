class AddColumnDateToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :date_of_video, :date
  end
end
