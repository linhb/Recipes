require 'spec_helper'

describe Recipe do
  before(:each) do
    @recipe_text = <<-EOD

      French bread

      Ingredients

      2.5 cups flour
      1.25 cups warm water      
      2.5 tbsp instant yeast
      1 tsp salt

      In food processor, pulse 2 cups flour with the water, yeast and salt until combined. Knead 45 seconds. Add remaining flour. Knead 60 seconds.

      Grease a large container. Put dough into container and allow to rise until doubled in a warm, draft-free place.

      Punch dough down and allow to double again.

      Shape into 2 baguettes. Allow to double.

      Preheat oven to 450.

      Bake 20 minutes or until bread is golden and sounds hollow when tapped.

    EOD
    @recipe = Recipe.new.parse(@recipe_text)
    @recipe.serving = 4
  end

  describe "recipe parsing" do
    it "should parse the name" do
      @recipe.name.should == "French bread"
    end

    it "should parse a standard-format recipe with an ingredient list with a header, even with extra spaces and newlines" do
      recipe = Recipe.new.parse(@recipe_text)
      recipe.name.should == "French bread"
      recipe.contents.gsub(/[\s\r\n]/, '').should == <<-EOD.gsub(/[\s\r\n]/, '')
In food processor, pulse 2 cups flour with the water, yeast and salt until combined. Knead 45 seconds. Add remaining flour. Knead 60 seconds.

        Grease a large container. Put dough into container and allow to rise until doubled in a warm, draft-free place.

        Punch dough down and allow to double again.

        Shape into 2 baguettes. Allow to double.

        Preheat oven to 450.

        Bake 20 minutes or until bread is golden and sounds hollow when tapped.
EOD
    end    
  end
  
  describe "scaling" do
    it "should scale correctly" do
      @recipe.scale(2).ingredients.map(&:amount).should == [1.25, 0.625, 1.25, 0.5]
    end
    
    it "should handle 0 serving" do
      @recipe.scale(0).ingredients.map(&:amount).should == [0, 0, 0, 0]
    end
    
    it "should report errors when serving < 0" do
      @recipe.scale(-3).should_not be_valid
    end
  end
end