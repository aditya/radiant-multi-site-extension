class AddSiteIdToLayouts < ActiveRecord::Migration
  def self.up
    add_column :layouts, :site_id, :integer
  end
  
  def self.down
    remove_column :layouts, :site_id
  end
end
