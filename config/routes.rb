Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  devise_scope :user do
    get  'addresses', to: 'users/registrations#address_registration'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root 'items#index'

  resources :items
  
    resources :items do
    get "set_parents"
    get "set_children"
    get "set_grandchildren"
  end


  resources :item_details, only: [:index, :edit, :update, :destroy]
  

    #購入機能実装時にitemsに対してネスト設定を行う（item_id情報を受け取るため）
    resources :purchases, only: [:index]

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

