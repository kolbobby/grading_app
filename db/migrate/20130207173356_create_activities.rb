class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.string :coach
      t.integer :marking_period
      t.integer :activity_number

      t.timestamps
    end
  end
end
