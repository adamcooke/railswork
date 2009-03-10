class CreatePaypalCallbacks < ActiveRecord::Migration
  def self.up
    create_table :paypal_callbacks do |t|
      t.text :callback_data
      t.string :txn_id
      t.string :payment_status
      t.string :status
      t.timestamps 
    end
  end

  def self.down
    drop_table :paypal_callbacks
  end
end
