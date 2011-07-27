class Recipe < ActiveRecord::Base
  validates_uniqueness_of :contents
  
  def search(keyword)
    
  end
end
