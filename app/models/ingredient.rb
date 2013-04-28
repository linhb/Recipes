class Ingredient < ActiveRecord::Base

  belongs_to :recipe

  validates :name, presence: true
  
  def self.parse(ingredient_list)
    ingredient_lines = ingredient_list.split(NEWLINE_CHARS).delete_if &:empty?
    ingredients = []
    ingredient_lines.each do |i|
      if match = i.match(/([\d\.\/\s]+) \s (\w+) \s (.+)/x)
        ingredients << Ingredient.new(amount: Ingredient.parse_fraction(match[1]), unit: match[2], name: match[3])
      end
    end
    ingredients
  end
  
  def to_s # TODO move this to a helper
    "#{amount_fraction} #{unit} #{name}"
  end
  
  def amount_fraction
    rational_amount = amount.to_r
    floor = rational_amount.floor
    fraction = rational_amount - floor
    fraction_str = "<sup>#{fraction.numerator}</sup>&frasl;<sub>#{fraction.denominator}</sub>"
    "#{floor if floor > 0} #{fraction_str if fraction > 0}"
  end

  def self.parse_fraction(str)
    match = str.match(/(\d*)\s*(\d+\/\d+)/)
    if match
      whole, fraction = match[1..2]
      value = whole.to_r + fraction.to_r
    else
      str.to_f
    end
  end
end
