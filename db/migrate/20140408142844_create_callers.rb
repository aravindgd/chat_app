class CreateCallers < ActiveRecord::Migration
  def change
    create_table :callers do |t|
      t.string :name
      t.integer :number
      t.boolean :activation, default: true
      t.string :call_type
      t.timestamps
    end
  end
end
