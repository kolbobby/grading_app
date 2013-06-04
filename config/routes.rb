GradingApp::Application.routes.draw do
  resources :users do
    get :autocomplete_student_name, :on => :collection
    member do
      get "view_home"
      get "setup_teachers"
      get "view_students"
      get "view_roster"
      get "manage_students"
      get "manage_activities"
      get "reset_application"
    end
  end
  resources :students
  resources :sessions, :only => [:new, :create, :destroy]

  root :to => "static_pages#index"

  match '/help', :to => 'static_pages#help'

  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy', :via => :delete

  match '/delete_student', :to => 'students#delete'
  match '/students/add_student', :to => 'students#add_student'
  match '/students/add_bulk_users_to_db', :to => 'students#add_bulk_users_to_db'

  post '/change_coach', :to => 'activities#change_coach'
  post '/get_activity', :to => 'activities#get_activity'
  post '/add_activities', :to => 'activities#add_activities'
  post '/update_capacity', :to => 'activities#update_capacity'
  post '/confirm_add', :to => 'activities#confirm_add_activities'
  post '/users/add_to_activity', :to => 'activities#add_to_activity'
  post '/load_student_activities', :to => 'activities#load_student_activities'

  match '/users/add_user', :to => 'users#add_user'
  match '/reload_teachers', :to => 'users#reload_teachers'
  match '/reload_students', :to => 'users#reload_students'
  match '/users/update_schedules', :to => 'users#update_schedules'
  match '/reload_schedules', :to => 'users#reload_schedules'
  match '/load_student_roster', :to => 'users#load_roster'
  match '/load_print_view', :to => 'users#print_view'
  match '/get_roster_title', :to => 'users#roster_title'
  match '/search_student', :to => 'users#search_student'

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
