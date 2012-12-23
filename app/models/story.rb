class Story < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :points
  belongs_to :project, :class_name => "Project", :foreign_key => "project_id"
  has_many :changes, :class_name => "Change", :foreign_key => "change_id"
  
  def children_stories
    Story.where(:project_id => self.project, :parent_story => self.id).order("created_at DESC")
  end
  
  def has_parent
    return self.parent_story?
  end
  
  def parent
    if self.parent_story
      Story.find(self.parent_story)
    else
      nil
    end
  end
  
  def has_children
    self.children_stories.size > 0
  end
  
  def is_leaf
    self.children_stories.size == 0
  end
  
  def is_single_child?
    parent_story = Story.new
    parent_story = Story.find self.parent_story if self.parent_story?
    parent_story.children_stories.size == 1
  end
  
  def format_for_json
    children = []
    
    self.children_stories.each do |child|
      children << child.format_for_json
    end
    
    return {
      id:"story_#{self.id}", 
      name:self.title,
      data:{},
      children:children
    }
  end
end
