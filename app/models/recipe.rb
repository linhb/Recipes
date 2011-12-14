class Recipe < ActiveRecord::Base
  validates_uniqueness_of :contents
  
  def self.search(keyword)
    if keyword.blank?
      scoped(:conditions => {})
    else
      scoped(:conditions => ["contents LIKE ?", "%#{keyword}%"])
    end
  end
end
