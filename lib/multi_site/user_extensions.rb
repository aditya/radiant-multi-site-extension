module MultiSite::UserExtensions
  def self.included(base)
    base.belongs_to :site
  end

  def owner?(multi_site)
    site == multi_site
  end
end
