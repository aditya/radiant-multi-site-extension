class AddUniqueIndexOnUsersLoginSiteId < ActiveRecord::Migration
  def self.up
    add_index :users, [:login, :site_id], :name => 'login_site_id'
  end
  
  def self.down
    remove_index :users, :name => 'login_site_id'
  end
end
