class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.references :callers, index: true
      t.references :receivers, index: true
      t.integer :order_id
      t.integer :call_type, default: 0

      t.timestamps
    end
  end
end
