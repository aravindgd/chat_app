class AddCallerIdToCallers < ActiveRecord::Migration
  def change
    add_column :callers, :caller_id, :string
  end
end
