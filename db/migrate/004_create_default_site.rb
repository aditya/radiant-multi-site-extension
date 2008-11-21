class CreateDefaultSite < ActiveRecord::Migration
  def self.up
    Site.create(:name => 'Default', :domain => '', :base_domain => 'default', :homepage => Page.find(:first, :conditions => "parent_id IS NULL"))
  end
  
  def self.down
  end
end
