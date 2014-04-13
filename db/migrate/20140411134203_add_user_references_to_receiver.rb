class AddUserReferencesToReceiver < ActiveRecord::Migration
  def change
    add_reference :receivers, :user, index: true
  end
end
