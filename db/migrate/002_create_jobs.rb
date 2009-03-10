class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.string :category
      
      t.string :title
      t.string :company_name
      t.string :location
      t.string :company_url
      t.string :salary_range
      t.text :description
      
      t.string :contact_email
      t.boolean :display_email, :default => true
      
      t.string :password
      
      t.decimal :cost, :precision => 8, :scale => 2, :default => 0.0
      t.decimal :discount, :precision => 8, :scale => 2, :default => 0.0
      
      t.datetime :activated_at
      
      t.timestamps 
    end
  end

  def self.down
    drop_table :jobs
  end
end
