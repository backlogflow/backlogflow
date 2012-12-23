require 'test_helper'
require 'pp'

class StoryTest < ActiveSupport::TestCase
  setup do
    @story = stories(:one)
    @story2 = stories(:two)
  end
  
  test "the truth" do
    assert true
  end
  
  test "should get children stories" do
    assert_equal [stories(:two)], @story.children_stories
  end
  
  test "story has parent" do
    assert_true @story2.has_parent
  end
  
  test "story has no parent" do
    assert_false @story.has_parent
  end
  
  test "should return parent story" do
    assert_equal stories(:one), @story2.parent
  end
  
  test "story has no parent should return nil" do
    assert_equal nil, @story.parent
  end
  
  test "story is leaf" do
    assert_true @story2.is_leaf
  end
  
  test "story isnt leaf" do
    assert_false @story.is_leaf
  end
  
  test "story is single child" do
    assert_true @story2.is_single_child?
  end
  
  test "story isnt single child" do
    assert_equal false, stories(:four).is_single_child?
  end
  
  test "story has children" do 
    assert stories(:one).has_children
  end
  
  test "story hasnt children" do
    assert_false stories(:done_leaf).has_children
  end
  
  test "format for json story without children" do
    expected = {
      id: "story_10", 
      name: "h1",
      data:{},
      children:[]
    }
    assert_equal expected, stories(:ten).format_for_json
  end
    
  test "format for json story with children" do
    expected = {
      id: "story_1", 
      name: "h1",
      data:{},
      children:[
        id: "story_2",
        name: "MyString",
        data:{},
        children:[]
      ]
    }
    assert_equal expected, stories(:one).format_for_json
  end
end
