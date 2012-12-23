require 'test_helper'

class StoriesControllerTest < ActionController::TestCase
  setup do
    @story = stories(:one)
    @story2 = stories(:two)
  end
  
  test "should destroy story" do
    assert_difference('Story.count', -1) do
      delete :destroy, :id => @story.id, :project_id => @story.project.id
    end    
  end
  
  test "destroy single child" do
    assert_difference('Story.count', -1) do
      delete :destroy, :id => @story2.id, :project_id => @story2.project.id
    end
  end
  
  test "should create story" do
    assert_difference('Story.count', 1) do
      delete :create, :story => @story.serializable_hash, :project_id => @story.project.id
    end    
  end
  
  test "should update story" do
    assert_difference("Story.find(#{@story.id}).points", 1) do
      put :update, :id => @story, :project_id => @story.project.id, :story => { :points => 2 }
    end
  end
  
  test "update status" do
    assert_equal "To Do", @story.status
    put :update_status, :id => @story, :project_id => @story.project.id, :status => "Done", :format => "js"
    assert_equal "Done", Story.find(@story.id).status
  end
  
  test "test order by position" do
    get :order, :project_id => @story.project.id, :order => "10,9,2"
    assert_equal 1, Story.find(10).position    
    assert_equal 2, Story.find(9).position    
    assert_equal 3, Story.find(2).position
  end 
  
end
