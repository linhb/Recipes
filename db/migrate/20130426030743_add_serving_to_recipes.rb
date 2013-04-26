class AddServingToRecipes < ActiveRecord::Migration
  def self.up
    add_column :recipes, :serving, :decimal
  end

  def self.down
    remove_column :recipes, :serving
  end
end
