class AddColumnShortDescriptionToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :short_description, :string
  end
end
