class AddReceiverIdToReceivers < ActiveRecord::Migration
  def change
    add_column :receivers, :receiver_id, :string
  end
end
