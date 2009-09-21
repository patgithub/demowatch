class AddEventTweetlevel < ActiveRecord::Migration
  def self.up
    add_column :events, :tweetlevel, :integer
    Event.all.each do |event|
      event.update_attribute(:tweetlevel, [0,event.calc_tweetlevel-1].max)
    end
  end

  def self.down
    remove_column :events, :tweetlevel
  end
end
