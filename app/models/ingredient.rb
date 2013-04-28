class Ingredient < ActiveRecord::Base

  belongs_to :recipe

  validates :name, presence: true
  validates :amount, numericality: {greater_than: 0}
  
  def self.parse(ingredient_list)
    ingredient_lines = ingredient_list.lines.delete_if &:empty?
    ingredients = []
    ingredient_lines.each do |i|
      if match = i.match(/([\d\.\/\s]+) \s (\w+) \s (.+)/x)
        ingredients << Ingredient.new(amount: Ingredient.parse_fraction(match[1]), unit: match[2], name: match[3])
      end
    end
    ingredients
  end
  
  def to_s
    "#{amount_fraction} #{unit} #{name}"
  end
  
  def amount_fraction
    rational_amount = amount.to_r
    floor = rational_amount.floor
    fraction = rational_amount - floor
    fraction_str = "<sup>#{fraction.numerator}</sup>&frasl;<sub>#{fraction.denominator}</sub>"
    # if both floor and fraction > 0, display both
    # floor only or fraction only > 0, display that
    # both 0, display 0
    # < 0, display "invalid"
    if floor > 0 || fraction > 0
      "#{floor if floor > 0} #{fraction_str if fraction > 0}"
    elsif floor == 0 && fraction == 0
      "0"
    else
      "<invalid>"
    end
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
