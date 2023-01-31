Rails.application.routes.draw do

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

   scope module: :public do

  root to:"homes#top"
  get "/about"=>"homes#about", as:"about"

    resources :items,only: [:index,:show,:edit]
    resource :customers,only: [:show,:edit,:update] do
      collection do
        get'/mypage' =>"customers#show"
        get'/information/edit' =>"customers#edit"
        patch'/information' =>"customers#update"
        get'unsubscribe'
        patch 'withdraw'
      end
    end

    resources :cart_items,only: [:index,:update,:destroy,:create] do
      collection do
        delete'destroy_all'
      end
    end

    resources :orders,only: [:new,:create,:index,:show] do
      collection do
        post'confirm'
        get'complete'
      end
    end

    resources :addresses,only: [:index,:edit,:create,:update,:destroy]
  end

  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

   namespace :admin do
    root to:"orders#index"
    resources :items
    resources :genres,only: [:index,:create,:edit,:update]
    resources :customers,only: [:index,:show,:edit,:update]
    resources :orders,only: [:show,:update]
    resources :order_items,only: [:update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
