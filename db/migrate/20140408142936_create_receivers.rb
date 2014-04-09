class CreateReceivers < ActiveRecord::Migration
  def change
    create_table :receivers do |t|
      t.string :name
      t.integer :number
      t.boolean :activation, default: true

      t.timestamps
    end
  end
end
