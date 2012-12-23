class AddColumnFatherToStory < ActiveRecord::Migration
  def change
    add_column :stories, :parent_story, :integer
  end
end
