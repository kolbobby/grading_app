class RemoveUsersUType < ActiveRecord::Migration
  def change
  	remove_column :users, :u_type
  end
end