class AddSlugColumns < ActiveRecord::Migration
  def change
    add_column :users, :slug, :string, :unique => true
    add_column :categories, :slug, :string, :unique => true
    add_column :levels, :slug, :string, :unique => true
    add_column :videos, :slug, :string, :unique => true
  end
end
