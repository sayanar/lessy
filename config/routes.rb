Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :users, only: [:create] do
      collection do
        get 'me', action: 'show'
      end
    end

    namespace :users do
      resources :authorizations, only: [:create]
      resources :activations, only: [:create]
    end

    resources :projects, only: [:create, :update, :index] do
      member do
        post 'start'
        post 'stop'
        post 'finish'
      end
    end

    resources :tasks, only: [:create, :update, :index] do
      member do
        post 'finish'
        post 'restart'
        post 'start'
        post 'abandon'
        post 'order_after'
      end
    end

    get '*path', to: 'welcome#not_found'
    post '*path', to: 'welcome#not_found'
    patch '*path', to: 'welcome#not_found'
    put '*path', to: 'welcome#not_found'
    delete '*path', to: 'welcome#not_found'
  end

  root 'application#client'
  get '*path', to: 'application#client'
end
