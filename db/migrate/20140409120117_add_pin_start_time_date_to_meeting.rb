class AddPinStartTimeDateToMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :pin, :integer
    add_column :meetings, :start_time, :time
    add_column :meetings, :start_date, :date
  end
end
