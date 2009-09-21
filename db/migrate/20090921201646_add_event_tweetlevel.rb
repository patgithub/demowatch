class AddEventTweetlevel < ActiveRecord::Migration
  def self.up
    add_column :events, :tweetlevel, :integer
  end

  def self.down
    remove_column :events, :tweetlevel
  end
end
