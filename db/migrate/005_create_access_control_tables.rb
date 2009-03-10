class CreateAccessControlTables < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
    	t.column :username, :string
    	t.column :hashed_password, :string
    	t.column :salt, :string
    	t.column :last_login, :datetime
    	t.column :access_level, :integer, :default => 2
    	t.column :enabled, :boolean, :default => true
	
    	
    	t.column :surname, :string
			t.column :forename, :string
			t.column :email, :string
	
			t.column :reset_password_key, :string
			t.column :reset_password_expiry, :datetime
			t.column :auto_login_token, :string
			
			t.column :deleted, :boolean, :default => false

    end
  end

  def self.down
    drop_table :users
  end
end