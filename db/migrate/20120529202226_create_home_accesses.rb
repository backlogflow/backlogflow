class CreateHomeAccesses < ActiveRecord::Migration
  def change
    create_table :home_accesses do |t|
      t.boolean :is_empty,  :default => false
      t.boolean :is_new,    :default => false
      t.integer :accesses,  :default => 0

      t.timestamps
    end
  end
end
