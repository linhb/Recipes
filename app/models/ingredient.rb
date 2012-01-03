class Ingredient < ActiveRecord::Base
  has_and_belongs_to_many :recipes, :join_table => :ingredient_inclusions

  validates :name, :presence => true
  
  def self.parse(ingredient_list)
    ingredient_lines = ingredient_list.split("\n").delete_if &:empty?
    ingredients = []
    ingredient_lines.each do |i|
      if match = i.match(/([\d\.\/\s]+) \s (\w+) \s (.+)/x)
        ingredients << Ingredient.new(:amount => Ingredient.parse_fraction(match[1]), :unit => match[2], :name => match[3])
      end
    end
    ingredients
  end
  
  def to_s
    "#{sprintf('%.1f', amount)} #{unit} #{name}"
  end
  
  def self.parse_fraction(str)
    match = str.match(/(\d*)\s*(\d+\/\d+)/)
    whole, fraction = match[1..2]
    value = whole.to_r + fraction.to_r
  end
end
