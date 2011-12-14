class AddNameToRecipe < ActiveRecord::Migration
  def self.up
    add_column :recipes, :name, :string
  end

  def self.down
    remove_column :recipes, :name
  end
end
