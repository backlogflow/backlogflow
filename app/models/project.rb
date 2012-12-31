class Project < ActiveRecord::Base
  validates_uniqueness_of :name
  validates_presence_of :name
  has_many :stories, :class_name => "Story"
  
  Status = {
     :TODO => "TO DO",
    :DOING => "DOING",
     :DONE => "DONE"  
  }
 
  def epics
    self.stories.where(:parent_story => nil).order("created_at DESC")
  end


  def leaf_stories
    stories = self.stories
    leaf = stories.select do |story|
      story.is_leaf
    end
    return leaf
  end
  
  
  def done_stories
    stories = self.stories.where(:status => Project::Status[:DONE]).order('done_date DESC')
    stories.select do |story|
      story.is_leaf
    end
  end
  
  
  def doing_stories
    stories = self.stories.where(:status => Project::Status[:DOING]).order(:updated_at)
    stories.select do |story|
      story.is_leaf
    end
  end
  
  
  def todo_stories
    stories = self.stories.where(:status => Project::Status[:TODO]).order(:position)
    stories.select do |story|
      story.is_leaf
    end
  end
  
  
  def greatest_position
    self.update_position
    max = self.stories.order("position DESC").first
    if not max.nil?
      return max.position || 0
    else
      return 0
    end
  end
  
  
  def update_position
    stories = self.todo_stories
    stories.each_with_index do |story, index|
      story.position = index + 1
      story.save
    end
  end
  
  
  def filtered_stories status
    if status == Project::Status[:DONE]
      return self.done_stories
    elsif status == Project::Status[:DOING]
      return self.doing_stories
    elsif status == Project::Status[:TODO]
      return self.todo_stories
    else
      return []
    end
  end
  
  
  def switch_position pos
    self.update_position
    self.todo_stories.each do |story|
      if story.position >= pos.to_i
        story.position = story.position+1
        story.save
      end
    end
  end
  
  
end
