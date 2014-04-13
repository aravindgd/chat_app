class AddUserReferencesToCaller < ActiveRecord::Migration
  def change
    add_reference :callers, :user, index: true
  end
end
