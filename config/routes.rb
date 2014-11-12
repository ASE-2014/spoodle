Rails.application.routes.draw do

  resources :events do
    resources :spoodle_dates do
      put :assign, on: :member
      put :cancel, on: :member
    end
    resources :invitations
  end

  devise_for :users,
             :controllers => { registrations: 'registrations',
                               sessions: 'sessions' }

  resources :users do
  end
  devise_scope :user do

    authenticated :user do
      root :to => "home#index", :as => "authenticated_root"
    end

    unauthenticated :user do
      root :to => 'welcome#index', as: :unauthenticated_root
    end

  end

  # Event routes
  get     'upcoming'         => 'events#upcoming', as: 'upcoming_events'
  get     'pending'          => 'events#pending',  as: 'pending_events'
  get     'passed'           => 'events#passed',   as: 'passed_events'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".



  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
