class ProjectsController < InheritedResources::Base
  respond_to :html, :js, :json
  
  def show
    project_name = params[:project_name].downcase
    @project = Project.where(:name => project_name).first
  
    if @project.nil?
      @project = Project.new
      @project.name = project_name
      @project.save
    end
    
    @story = @project.stories.new
    show!
  end

  def filter
    @project = Project.find params[:project_id]
    
    if params[:status] == "All"
      @filtered_stories = @project.epics
    else
      @filtered_stories = @project.filtered_stories params[:status]
    end
    
    render 'filter'
  end
  
  def home_count
    name = params[:project_name]
    HomeAccess.new_access name
    
    render :nothing => true
  end
  
  def report
    @changes = Change.where( "old_points != new_points" )
    render 'report'
  end
  
  def mind_map
    @project = Project.where( :name => params[:project_name] ).first
    render 'mind_map'    
  end
  
  def stories_for_mind_map
    @project = Project.find params[:id]
    stories = []
    
    @project.epics.each do |epic|
      epic_json = epic.format_for_json
      epic.children_stories
      stories << epic_json
    end
    
    json = {
      id:"project_#{@project.id}",
      name:@project.name,
      data:{},
      children:stories
    }
    render :json => json
  end
  
  
end











