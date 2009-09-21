class AddEventTweetlevel < ActiveRecord::Migration
  def self.up
    add_column :events, :tweetlevel, :integer
    Event.all.each do |event|
      event.init_tweetlevel
    end
  end

  def self.down
    remove_column :events, :tweetlevel
  end
end
