class AddEventOwner < ActiveRecord::Migration
  def self.up
    add_column :events, "user_id", :integer
    Event.reset_column_information
    # migrate organizer relations into user_id
    Event.find_with_deleted(:all).each do |event|
      puts event.id
      if event.organisation
        puts event.organisation.users.first.login
        event.user_id = event.organisation.users.first.id
        event.save
      end
    end
    Event.update_all( "user_id=3", "user_id is null" );
    change_column :events, "user_id", :integer, :null => false
  end

  def self.down
    remove_column :events, "user_id"
  end
end
