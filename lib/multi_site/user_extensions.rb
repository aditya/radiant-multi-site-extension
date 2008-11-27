module MultiSite::UserExtensions

  # Remove this from the base User model since we want to scope it by site and
  # ther's no clean way of overriding it.
  def self.included(base)
    base.class_eval {
      base.validates_uniqueness_of :login, :message => 'login already in use', :scope => :site_id
    }
  end
end
