class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :hashed_password
      t.boolean :enabled, :default => true, :null => false
      t.text :profile
      t.datetime :last_login

      t.timestamps
    end
    
    admin_user = User.create(:username => 'admin', 
                             :email => 'admin@123.com',
                             :profile => 'Administrator',
                             :password => 'admin', 
                             :password_confirmation => 'admin')
    admin_role = Role.find_by_name('Administrator')
    admin_user.roles << admin_role
  end

  def self.down
    drop_table :users
  end
end
