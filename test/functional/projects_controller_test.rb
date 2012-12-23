require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      get :show, :project_name => "newproject"
    end
  end

  test "should show project" do
    get :show, :project_name => @project.name
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @project.to_param
    assert_response :success
  end

  test "should update project" do
    put :update, :id => @project.to_param, :project => @project.attributes
    assert_redirected_to project_path(assigns(:project))
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete :destroy, :id => @project.to_param
    end

    assert_redirected_to projects_path
  end
  
  test "should get mind map" do
    get :mind_map, :project_name => @project.name
    assert_response :success
  end
  
  test "access from home updates home count" do
    get :home_count, :project_name => @project.name
    assert_response :success
  end
  
  test "report for story changes" do
    get :report
    assert_response :success
  end
  
  test "get stories json for mind map" do
    get :stories_for_mind_map, :id => 1
    assert_response :success
  end
  
  test "should get filter all" do
    get :filter, :status => "All", :project_id => 1, :format => 'js'
    assert_response :success
  end
  
  test "should get filter" do
    get :filter, :status => "Doing", :project_id => 1, :format => 'js'
    assert_response :success
  end
  
end
