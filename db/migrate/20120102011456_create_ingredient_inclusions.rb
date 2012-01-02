class CreateIngredientInclusions < ActiveRecord::Migration
  def self.up
    create_table :ingredient_inclusions, :id => false do |t|
      t.references :ingredient
      t.references :recipe
    end
  end

  def self.down
    drop_table :ingredient_inclusions
  end
end
