class RemoveIngredientInclusion < ActiveRecord::Migration
  def up
    drop_table :ingredient_inclusions
  end

  def down
    create_table :ingredient_inclusions
  end
end
