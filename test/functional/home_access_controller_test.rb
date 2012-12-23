require 'test_helper'

class HomeAccessesControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
    @empty = home_accesses(:empty)
    @new   = home_accesses(:new)
  end

  test "new access with existing project" do
    HomeAccess.new_access @project.name
    assert_equal 0, @empty.accesses
    assert_equal 0, @new.accesses
  end

  test "new access with empty name" do
    assert_difference("HomeAccess.find(#{@empty.id}).accesses", 1) do
      HomeAccess.new_access " "
    end
    assert_equal 0, @new.accesses
  end

  test "new access with new project" do
    assert_difference("HomeAccess.find(#{@new.id}).accesses", 1) do
      HomeAccess.new_access "new_project"
    end
    assert_equal 0, @empty.accesses
  end
end