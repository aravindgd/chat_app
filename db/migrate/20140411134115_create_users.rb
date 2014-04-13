class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :external_caller_id
      t.string :external_receiver_id

      t.timestamps
    end
  end
end
