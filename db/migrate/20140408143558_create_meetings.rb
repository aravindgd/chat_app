class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.references :caller, index: true
      t.references :receiver, index: true
      t.references :api_key, index: true
      t.integer :order_id
      t.integer :duration
      t.timestamps
    end
  end
end
