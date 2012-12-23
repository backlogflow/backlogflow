class AddDoneDateToStories < ActiveRecord::Migration
  def change
    add_column :stories, :done_date, :datetime
  end
end
