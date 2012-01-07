class Recipe < ActiveRecord::Base
  validates :name, :contents, :presence => true
  validates :serving, numericality: true
  attr_accessor :parse_status, :ingredient_list
  # possible statuses: 
    # 'parsed' if entered with correct sections -> still need to parse for ingredients but just line by line
    # 'unparsed' if needs parsing
  before_create :parse
  
  has_and_belongs_to_many :ingredients, :join_table => :ingredient_inclusions
   
  default_scope :order => 'created_at DESC'
  
  def self.search(keyword)
    if keyword.blank?
      scoped
    else
      where ["name LIKE ?", "%#{keyword}%"]
    end
  end
  
  def parse
    if parse_status == "unparsed"
      if contents.match(/\ningredients\n/i)
        parse_with_ingredients
      else
        parse_no_ingredients
      end
    elsif parse_status == "parsed"
      parse_ingredients
    end
  end
  
  def parse_with_ingredients
    # how to tell an ingredient section: newline, 'ingredients', >=1 occurrences of number-space->=1 characters-newline
    name = /(.+)\r\n/x
    ingredient_heading = /(\r\n)* ingredients/ix 
    ingredient_list = /\n([\d\.\/]+\s.+)/x
    directions = /((.|\n)+)/x
    match = contents.match(/#{name} #{ingredient_heading} #{ingredient_list} #{directions}/x)
    self.name, self.contents = match[1..2]    
  end
  
  def parse_no_ingredients
    match = contents.match(/(.+)(\r\n(.|\n)+)/)
    self.name, self.contents = match[1..2]
  end
  
  def parse_ingredients
    self.ingredients = Ingredient.parse(ingredient_list)
  end
  
  def scale(new_serving)
    new_serving ||= serving
    copy = self.clone
    copy.ingredients.clear
    ratio = (new_serving.to_f / serving).to_f
    ingredients.each do |i|
      i.amount = ratio * i.amount
      copy.ingredients << i
    end
    copy
  end
end
