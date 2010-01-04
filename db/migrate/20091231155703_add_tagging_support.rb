class AddTaggingSupport < ActiveRecord::Migration
  def self.up
    create_table :tags, :force => true do |t|
      t.string :name
    end
    
    create_table :taggings, :force => true do |t|
      t.integer :tag_id
      t.integer :taggable_id
      t.string :taggable_type
      t.datetime :created_at
    end
    # add index
    add_index :tags, :name
    add_index :taggings, [:tag_id, :taggable_id, :taggable_type]
  end
  
  def self.down
    drop_table :tags
    drop_table :taggings
  end
end
