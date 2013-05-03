class ChangeStudentsPeriodToString < ActiveRecord::Migration
  def change
  	change_column :students, :period, :string
  end
end