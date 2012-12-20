class AddMoreFieldsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :uname, :string
  	add_column :users, :password_digest, :string
  end
end
