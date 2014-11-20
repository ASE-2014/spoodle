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
    member do #TODO maybe simply 'get :friends, on: :member'?
      get :friends
    end
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

  # Event routes #TODO put into resources :events
  get     'upcoming'         => 'events#upcoming', as: 'upcoming_events'
  get     'pending'          => 'events#pending',  as: 'pending_events'
  get     'passed'           => 'events#passed',   as: 'passed_events'

end