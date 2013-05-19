class AddAttachmentPhotoToRecipes < ActiveRecord::Migration
  def self.up
    change_table :recipes do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :recipes, :photo
  end
end
