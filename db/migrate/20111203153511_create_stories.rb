class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.string :description
      t.string :details
      t.integer :points
      t.string :value
      t.string :status

      t.timestamps
    end
  end
end
