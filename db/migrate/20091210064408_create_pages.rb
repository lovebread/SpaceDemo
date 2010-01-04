class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title
      t.string :permalink
      t.text :body
      t.timestamps
      
    end
    
    Page.create(:title => "SpaceDemo Home", 
                :permalink => "welcome-page", 
                :body => "Welcome to Space")
  end

  def self.down
    drop_table :pages
  end
end
