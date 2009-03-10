ActionController::Routing::Routes.draw do |map|
  
  map.with_options :controller => "jobs", :action => "index" do |jobs|
    jobs.category "jobs/:category", :requirements => {:category => /all|design|technical|other|community/}
    jobs.formatted_category "jobs/:category.:format", :requirements => {:category => /all|design|technical|other|community/}
    jobs.home "", :category => "all"
  end
  
  map.resources :jobs, :member => {:confirm => :get, :remove => :get}, :collection => {:latest => :get}
  map.resources :coupons
  map.search "search", :controller => "search"
  
  map.with_options :controller => "sessions" do |sessions|
    sessions.login "admin/login", :action => "new"
    sessions.logout "admin/logout", :action => "destroy"
  end
  
  map.ipn 'ipn', :controller => 'jobs', :action => 'ipn'
  
  map.page ":action", :controller => "pages"
  
end
