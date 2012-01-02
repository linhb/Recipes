class Recipe < ActiveRecord::Base
  validates :contents, :presence => true
  before_create :parse
  
  has_and_belongs_to_many :ingredients, :join_table => :ingredient_inclusions
   
  def self.search(keyword)
    if keyword.blank?
      scoped
    else
      where ["name LIKE ?", "%#{keyword}%"]
    end
  end
  
  def parse
    match = contents.match(/(.+)(\r\n(.|\n)+)/)
    self.name, self.contents = match[1..2]
  end
end
