class HomeAccess < ActiveRecord::Base
  
  def self.new_access project_name
    if project_name.strip.empty?
      access = HomeAccess.where(:is_empty => true).first
      access.accesses = access.accesses + 1
      access.save
    elsif Project.where(:name => project_name).count > 0
      return
    else
      access = HomeAccess.where(:is_new => true).first
      access.accesses = access.accesses + 1
      access.save
    end
  end
end
