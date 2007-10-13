ActionController::Routing::Routes.draw do |map|
  map.resources :railevances

  map.resources :concepts

  map.resources :railsers
  map.resource :session
  map.signup '/signup', :controller => 'railsers', :action => 'new'
  map.login  '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.activate '/activate/:activation_code', :controller => 'railsers', :action => 'activate'
  
  map.resources *%w[dependency combination trait compatibility directory library api feature release version license script file klass project revision incompatibility block line mojule keyword tool command recipe routine methid variable constant expression strin statement join snippet example argument structure symbl alias query output route word dataset datapoint assignment return
    interaction debate history convention syntax language regularexpression title capability behavior bounty bug tracker spec log report duration outofdate answer question goal prediction expertise group event vehicle place plan moment day year gig company offer picture audio vid series presentation refactor critique compliment opinion strategy aggregator blog post comment site link resource search correction optimization
    contribution suggestion recommendation reference book topic pattern course chapter page tip thought idea summary extension tesst decision conclusion reason disagreement experiment lesson exercise template abstraction implementation wish preference alternative frustratedattempt email message listserv forum irc phone call visit host traffic metaphordefinition translation equivalence].map(&:pluralize).map(&:to_sym).push({:controller => 'concepts'})
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
