Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :levels
  resources :technologies
  resources :videos
  resources :categories
  match "/tag/:tag" =>"videos#index", as: "video_tag", :constraints => { :tag => /.*/ }, via: [:get]
  match "/category/:category" =>"videos#index", as: "video_category", :constraints => { :category => /.*/ }, via: [:get]

  root :to => 'home#index'
end
