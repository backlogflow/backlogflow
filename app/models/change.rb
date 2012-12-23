class Change < ActiveRecord::Base
  belongs_to :story, :class_name => "Story", :foreign_key => "story_id"
  
end
