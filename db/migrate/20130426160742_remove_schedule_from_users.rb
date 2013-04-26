class RemoveScheduleFromUsers < ActiveRecord::Migration
  def change
	  remove_column :users, :schedule
  end
end