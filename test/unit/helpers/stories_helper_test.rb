require 'test_helper'

class StoriesHelperTest < ActionView::TestCase
  test "should return a new story with parent story = story.id" do
    assert_equal 10, new_story(10).parent_story
  end
end
