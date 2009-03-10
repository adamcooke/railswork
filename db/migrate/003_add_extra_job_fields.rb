class AddExtraJobFields < ActiveRecord::Migration
  def self.up
    add_column :jobs, :expires_at, :datetime
    add_column :jobs, :listing_length, :integer
    add_column :jobs, :application_instructions, :text
  end

  def self.down
    remove_column :jobs, :expires_at
    remove_column :jobs, :listing_length
    remove_column :jobs, :application_instructions
  end
end
