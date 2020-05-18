Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  devise_scope :user do
    get  'addresses', to: 'users/registrations#address_registration'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root 'items#index'

  resources :items do
    resources :purchases, only: [:index] do
      collection do
        post 'pay', to: 'purchases#pay'
        end
      end
    end
  
    resources :items do
    get "set_parents"
    get "set_children"
    get "set_grandzchildren"
  end

    resources :credit_cards, only: [:new, :show, :destroy] do
      collection do
        post 'pay', to: 'credit_cards#pay'
      end
    end
 
  resources :users, only: [:show] do
    collection do
      get "log_in"
      get "new_user"
    end
  end 
end

