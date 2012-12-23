class CreateChanges < ActiveRecord::Migration
  def change
    create_table :changes do |t|
      t.integer :story_id
      t.integer :old_points
      t.integer :new_points

      t.timestamps
    end
  end
end
