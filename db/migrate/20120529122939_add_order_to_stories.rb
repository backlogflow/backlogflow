class AddOrderToStories < ActiveRecord::Migration
  def change
    add_column :stories, :order, :integer, :null => true
  end
end
