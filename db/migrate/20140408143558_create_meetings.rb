class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.references :caller, index: true
      t.references :receiver, index: true
      t.integer :order_id
      t.integer :duration
      t.integer :call_type, default: 0

      t.timestamps
    end
  end
end
