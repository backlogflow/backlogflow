module StoriesHelper
  
  def new_story(story_id)
    Story.new(:parent_story => story_id)
  end


  def delete_msg story
    num_of_deleted_stories = (story.children_stories.size + 1)
    
    # return "You'll delete " + num_of_deleted_stories.to_s + " stories.\nAre you sure?" if num_of_deleted_stories > 1
    return "You'll delete all children stories.\nAre you sure?" if(num_of_deleted_stories > 1)
    return "Are you sure?"
  end
  
end
