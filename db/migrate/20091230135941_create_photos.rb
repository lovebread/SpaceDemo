class CreatePhotos < ActiveRecord::Migration
  PHOTO_CONT_MAX_LEN = 100
  PHOTO_FILENAME_MAX_LEN = 255
  PHOTO_PATH_MAX_LEN = 255
  PHOTO_THUMBNAIL_MAX_LEN = 255
  
  def self.up
    create_table :photos do |t|
      t.integer :user_id
      t.string :title
      t.text :body
      
      # for attachment_fu
      t.string :content_type, :limit => PHOTO_CONT_MAX_LEN
      t.string :filename,  :limit => PHOTO_FILENAME_MAX_LEN
      t.string :path, :limit => PHOTO_PATH_MAX_LEN
      t.integer :parent_id
      t.string :thumbnail, :limit => PHOTO_THUMBNAIL_MAX_LEN
      t.integer :size
      t.integer :width
      t.integer :height
      t.timestamps
    end
    add_column :users, :photos_count, :integer
  end

  def self.down
    drop_table :photos
    remove_column :users, :photos_count
  end
end
