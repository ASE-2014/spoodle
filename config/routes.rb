Rails.application.routes.draw do

  resources :events do

    resources :spoodle_dates do
      put :assign, on: :member
      put :cancel, on: :member
    end

    resources :invitations

    resources :event_datas do
      resources :documents
    end

  end

  devise_for :users,
             :controllers => { registrations: 'registrations',
                               sessions: 'sessions',
                               omniauth_callbacks: "omniauth_callbacks"}

  resources :users do
    get :friends, on: :member
  end

  resources :friendships

  devise_scope :user do

    authenticated :user do
      root :to => "home#index", :as => "authenticated_root"
    end

    unauthenticated :user do
      root :to => 'welcome#index', as: :unauthenticated_root
    end

  end

  get :data_center, to: 'data_center#show'

  get :upcoming,  to: 'events#upcoming', as: 'upcoming_events'
  get :pending,   to: 'events#pending',  as: 'pending_events'
  get :passed,    to: 'events#passed',   as: 'passed_events'

end