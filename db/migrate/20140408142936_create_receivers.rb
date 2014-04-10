class CreateReceivers < ActiveRecord::Migration
  def change
    create_table :receivers do |t|
      t.string :name
      t.integer :number
      t.boolean :activation, default: true
      t.string :call_type
      t.timestamps
    end
  end
end
