require_dependency 'application'

class MultiSiteExtension < Radiant::Extension
  version "0.2"
  description %{ Enables virtual sites to be created with associated domain names.
                 Also scopes the sitemap view to any given page (or the root of an
                 individual site). }
  url "http://dev.radiantcms.org/svn/radiant/trunk/extensions/multi_site"
  
  define_routes do |map|
      map.resources :sites, :path_prefix => "/admin", 
                  :member => {
                    :move_higher => :post,
                    :move_lower => :post,
                    :move_to_top => :put,
                    :move_to_bottom => :put
                  }
  end
  
  def activate
    require 'slugify'
    require_dependency 'application'
    
    Page.send :include, MultiSite::PageExtensions
    Page.send :include, MultiSite::PageTags
    ResponseCache.send :include, MultiSite::ResponseCacheExtensions
    User.send :include, MultiSite::UserExtensions
    Layout.send :include, MultiSite::LayoutExtensions
    SiteController.send :include, MultiSite::SiteControllerExtensions
    Admin::PageController.send :include, MultiSite::PageControllerExtensions
    Admin::SnippetController.send :include, MultiSite::SnippetControllerExtensions

    Radiant::Config["dev.host"] = 'preview'

    # Add site navigation
    admin.page.index.add :top, "site_subnav"
    admin.tabs.add "Sites", "/admin/sites", :visibility => [:admin]

    # Make snippets visible only to admins and developers
    admin.tabs.remove "Snippets"
    admin.tabs.add "Snippets", "/admin/snippets", :before => "Layouts", :visibility => [:admin, :developer]

    # Add site admin scoping fields
    admin.user.edit.add :form, "site", :before => "edit_table_footer"
    admin.layout.edit.add :form, "site", :before => "edit_timestamp"
  end
  
  def deactivate
    admin.tabs.remove "Sites"
  end
  
end
