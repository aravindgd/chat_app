class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uniq_id
      t.string :name
      t.integer :number

      t.timestamps
    end
  end
end
