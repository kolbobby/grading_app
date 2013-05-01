class AddCapacityToActivities < ActiveRecord::Migration
  def change
  	add_column :activities, :capacity, :integer
  end
end