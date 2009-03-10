class CreateCoupons < ActiveRecord::Migration
  def self.up
    create_table :coupons do |t|
      t.string :code
      t.string :amount
      t.string :discount_type, :default => "percent"
      t.boolean :global, :default => true
      t.boolean :expired, :default => false
      t.integer :uses, :default => 0
    end
  end

  def self.down
    drop_table :coupons
  end
end
