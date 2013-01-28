class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.integer :grade_level
      t.integer :period
      t.string :sign_in_teacher

      t.timestamps
    end
  end
end
