JustPlan2::Application.routes.draw do
  root :to => 'application#home'
  
  resources :projects do
    resources :stories
  end
  
  #Rota para quando entra no projeto
  match '/:project_name' => 'projects#show'
  
  #Links Principais  
  match '/:project_name/mindmap' => 'projects#mind_map'
  match '/:project_name/board'   => 'board#show'
  match '/:project_name/epics'   => 'projects#show'

  #Rota para atualizar o status da  historia
  match '/project/:project_id/story/:id/update_status/:status' => 'stories#update_status'
  
  #Rota para filtrar as histórias de acordo com seu status
  match "/project/:project_id/filter/:status" => 'projects#filter'

  #AJUDA  
  match '/project/:project_id/story/order' => 'stories#order'
  match '/changes/report' => 'projects#report'
  match '/home_count/(:project_name)' => 'projects#home_count'
  match '/project/:id/stories.json' => 'projects#stories_for_mind_map'
  
  
  
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
  # match ':controller(/:action(/:id(.:format)))'
end
