class AddTitleAndUrlAndImageAndDescriptionToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :title, :string
    add_column :tweets, :url, :string
    add_column :tweets, :image, :string
    add_column :tweets, :description, :string
  end
end
