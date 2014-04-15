class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uniq_id
      t.string :name
      t.integer :number
      t.references :api_key, index: true

      t.timestamps
    end
  end
end
