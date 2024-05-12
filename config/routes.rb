Rails.application.routes.draw do
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check
  root 'bills#index'

  resources :bills do
    collection do
      get :search
    end
  end
end
