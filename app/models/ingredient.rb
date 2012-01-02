class Ingredient < ActiveRecord::Base
  
  has_and_belongs_to_many :recipes, :join_table => :ingredient_inclusions
end
