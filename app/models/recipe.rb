class Recipe < ActiveRecord::Base
  validates :contents, :presence => true
  before_create :parse
  
  def self.search(keyword)
    if keyword.blank?
      scoped
    else
      where ["name LIKE ?", "%#{keyword}%"]
    end
  end
  
  def parse
    match = contents.match(/(.+)(\r\n(.|\n)+)/)
    self.name = match[1]
    self.contents = match[2]
  end
end
