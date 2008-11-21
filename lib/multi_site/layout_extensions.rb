module MultiSite::LayoutExtensions
  def self.included(base)
    base.belongs_to :site
    base.extend ClassMethods
  end

  module ClassMethods
    def scoped_to_site(site_id, &block)
      with_scope(:find => { :conditions => ["site_id = ? OR site_id IS NULL", site_id] }, &block)
    end
  end
end
