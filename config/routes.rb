Rails.application.routes.draw do
  get 'sessions/new'

  root to: 'static_pages#home'
  get 'signup', to: 'users#new'
  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
 
  
  resources :users do
    member do
      get :followings, :followers # このようにカンマ区切りでリファクタリングできる
      # get 'followings'
      # get 'follower'
      get 'test' # userのテスト用
    end
    
    collection do
      get 'test2'
    end
  end

  resources :microposts do
    collection do
      post :retweet
    end
  end




  
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts
  resources :relationships, only: [:create, :destroy]
end
