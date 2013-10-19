class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name, null: false
      t.string :privacy, default: "private"
      t.boolean :completed, default: false
      t.integer :user_id, null: false
      t.timestamps
    end
    add_index :goals, :user_id
  end
end
