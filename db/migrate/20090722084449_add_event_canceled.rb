class AddEventCanceled < ActiveRecord::Migration
  def self.up
    add_column :events, :canceled, :bool, :default => false
  end

  def self.down
    remove_column :events, :canceled
  end
end
