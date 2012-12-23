class StoriesController < InheritedResources::Base
  belongs_to :project
  respond_to :html, :json, :js
  
  def destroy
    @story = Story.find params["id"]
    if not @story.nil? and @story.is_single_child?
      parent_story = Story.find @story.parent_story
      parent_story.position = @story.position
      parent_story.status = @story.status
      parent_story.save
    end
    destroy!
    if @story.status == 'To Do'
      @story.project.update_position
    end
  end
  
  def create
    @project = Project.find params["project_id"]
    if params["story"]["position"].to_i < @project.greatest_position
      @project.switch_position params["story"]["position"].to_i
    end
    params["story"]["points"] = -1 if( params["story"]["points"].nil? or params["story"]["points"] == "" or params["story"]["points"] == "?" )
    params["story"]["status"] = "To Do" if( params["story"]["status"].nil? or params["story"]["status"] == "" )
    params["story"]["position"] = @project.greatest_position + 1 if( params["story"]["position"].nil? )
    create!
  end

  def update
    @story = Story.find params["id"]
    
    if @story.points != params["story"]["points"]
      change = Change.new :story_id => @story.id, :old_points => @story.points, :new_points => params["story"]["points"]
      change.save
    end

    params["story"]["points"] = "-1" if( params["story"]["points"].nil? or params["story"]["points"].empty? or params["story"]["points"] == "?" )
    @story.project.update_position
    update!
  end
  
  def update_status
    story = Story.find params["id"]
    old_status = story.status
    story.status = params["status"]
    if params["status"] == "Done"
      story.done_date = Time.now
    end
    story.save
    @project = story.project

    if old_status == 'To Do' or params["status"] == 'To Do'
      @project.update_position
    end

    render "update", :project => story.project
  end
  
  def order
    Story.update_all({:position => 0}, {:project_id => params["project_id"]})
    stories_id = params[:order].split(",")
    stories_id.each_with_index do |story_id, index|
      story = Story.find story_id
      story.position = index + 1
      story.save
    end
    render :nothing => true
  end
end
