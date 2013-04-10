GradingApp::Application.routes.draw do
  resources :users do
    member do
      get "view_home"
      get "add_teacher"
      get "view_students"
      get "view_roster"
      get "manage_students"
      get "manage_activities"
    end
  end
  resources :students
  resources :sessions, :only => [:new, :create, :destroy]

  root :to => "static_pages#index"

  match '/help', :to => 'static_pages#help'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy', :via => :delete
  match '/students/add_bulk_users_to_db', :to => 'students#add_bulk_users_to_db'
  match '/users/add_user', :to => 'users#add_user'
  match '/students/add_student', :to => 'students#add_student'

  post '/change_coach', :to => 'activities#change_coach'
  post '/get_activity', :to => 'activities#get_activity'
  post '/add_activities', :to => 'activities#add_activities'
  post '/confirm_add', :to => 'activities#confirm_add_activities'

  match '/reload_students', :to => 'users#reload_students'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
