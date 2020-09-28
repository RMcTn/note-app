Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  resources :entries do
    collection do
      get :search
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
end
