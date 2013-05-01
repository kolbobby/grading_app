class RemoveColumnsFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :grade_level
  	remove_column :users, :period
  	remove_column :users, :sign_in_teacher
  end
end