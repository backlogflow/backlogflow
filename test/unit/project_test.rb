require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  setup do
    @project = projects(:one)
  end
  
  test "the truth" do
    assert true
  end
  
  test "should get stories" do
    assert_equal 7, @project.stories.size
  end
  
  test "should get epics" do
    assert_equal 5, @project.epics.size
  end
  
  test "should get leaf stories" do
    assert_equal 5, @project.leaf_stories.size
  end
  
  test "should get done leaf stories" do
    assert_equal 1, @project.done_stories.size
  end
  
  test "should get to do leaf stories" do
    assert_equal 3, @project.todo_stories.size
  end
  
  test "should get doing leaf stories" do
    assert_equal 1, @project.doing_stories.size
  end
  
  test "should get greatest position" do
    assert_equal 3, @project.greatest_position
  end
  
  test "should return filtered todo stories" do
    assert_equal 3, @project.filtered_stories("To Do").size 
  end
  
  test "should return filtered doing stories" do
    assert_equal 1, @project.filtered_stories("Doing").size 
  end
  
  test "should return filtered done stories" do
    assert_equal 1, @project.filtered_stories("Done").size 
  end

  test "should return empty list if status is invalid" do
    assert_equal [], @project.filtered_stories("Bla")
  end
  
  test "switch position" do
    @project.switch_position 3
    assert_equal 2, stories(:nine).position
    assert_equal 4, stories(:ten).position
  end
  
  test "position should be unique" do
    @project.update_position
    assert_not_equal stories(:nine).position, stories(:ten).position
  end
  
end

