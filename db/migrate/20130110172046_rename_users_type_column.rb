class RenameUsersTypeColumn < ActiveRecord::Migration
  def change
  	rename_column :users, :type, :u_type
  end
end