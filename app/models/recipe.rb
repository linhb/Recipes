class Recipe < ActiveRecord::Base
  validates :name, :contents, presence: true
  validates :serving, numericality: {greater_than: 0}, presence: true
  
  attr_accessor :ingredient_list
    
  has_many :ingredients, dependent: :destroy
  validates_associated :ingredients, unless: "serving > 0"
   
  default_scope order: 'created_at DESC'
  
  def self.search(keyword)
    if keyword.blank?
      scoped
    else
      where ["name LIKE ?", "%#{keyword}%"]
    end
  end
  
  def parse(unparsed_contents)
    components = recipe_components(unparsed_contents)
    self.name, self.contents = components[:name], components[:contents]
    self.ingredients = Ingredient.parse(components[:ingredient_list])
    self
  end
  
  def recipe_components(unparsed_contents)
    unless @components 
      components = unparsed_contents.strip.gsub(/\r/, "").split("\n\n", 4)
      components = components - [components[1]] # ignore paragraph 2; it's just the Ingredients header
      @components = Hash[[:name, :ingredient_list, :contents].zip(components)]
    end
    @components
  end
  
  def scale(new_serving)
    new_serving ||= serving
    copy = self.dup
    copy.serving = new_serving
    ratio = new_serving.to_f / serving
    ingredients.each do |i|
      temp_i = i.dup
      temp_i.amount = ratio * i.amount
      copy.ingredients << temp_i
    end
    copy
  end
end