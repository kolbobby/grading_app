class AddFieldsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :grade_level, :integer
  	add_column :users, :period, :integer
  	add_column :users, :sign_in_teacher, :string
  end
end