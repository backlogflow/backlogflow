class BoardController < ApplicationController
  respond_to :html, :js, :json
  
  def show
      @project = Project.where(:name => params[:project_name]).first
      @stories_todo  = @project.todo_stories;
      @stories_doing = @project.doing_stories;
      @stories_done  = @project.done_stories;
  end
end
