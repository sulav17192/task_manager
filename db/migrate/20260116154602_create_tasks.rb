class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :status
      t.date :due_date
      t.integer :creator_id
      t.integer :assigned_to_id

      t.timestamps
    end
  end
end
