class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :video
      t.string :slide
      t.integer :level_id
      t.integer :category_id
      t.integer :views
      t.boolean :published, :default => false

      t.timestamps
    end

  end
end
