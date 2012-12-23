class IncreaseSizeOfDescriptionFieldInStoriesTable < ActiveRecord::Migration
  def up
    change_column :stories, :description, :string, :lenght => 10000
    change_column :stories, :details, :string, :lenght => 10000
  end

  def down
    change_column :stories, :description, :string, :lenght => 255
    change_column :stories, :details, :string, :lenght => 255
  end
end
