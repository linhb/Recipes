require 'spec_helper'

describe Ingredient do
  describe "ingredient parsing" do
    it "should parse a set of ingredients" do
      @ingredient_list = <<-EOD
        2.5 cups flour
        1.25 cups warm water      
        2.5 tbsp instant yeast
        1 tsp salt
      EOD
      list = Ingredient.parse(@ingredient_list)
      list.size.should == 4
      list[2].amount.should == 2.5
    end
    it "should catch invalid ingredients" do 
      Ingredient.new.should_not be_valid
      Ingredient.new(name: "tasty food").should_not be_valid
      Ingredient.new(name: "tasty food", amount: 1).should_not be_valid
      Ingredient.new(name: "tasty food", amount: -1, recipe_id: 1).should_not be_valid
      Ingredient.new(name: "tasty food", amount: 1, recipe_id: 1).should be_valid
    end
  end
end