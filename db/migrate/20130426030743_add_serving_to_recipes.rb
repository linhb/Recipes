class AddServingToRecipes < ActiveRecord::Migration
  def self.up
    add_column :recipes, :serving, :decimal, default: 4
  end

  def self.down
    remove_column :recipes, :serving
  end
end
