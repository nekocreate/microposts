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
      #get 'alltweet'
    end
    
    collection do
      #get 'alluserstweets'
      get 'test2'
      get 'alltweet'
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
  resources :relationfavotweets, only: [:create, :destroy]
end
