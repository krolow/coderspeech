Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :levels  
  resources :categories
  
  get "/contact" => "contact#index", as: "contact"
  get "/technology/:tag" =>"videos#index", as: "video_tag"
  get "/videos/:category/:id/edit" => "videos#edit", as: "video_edit"
  get "/videos/:category/:id" =>"videos#show", as: "video_show"
  get "/videos/:category" =>"videos#index", as: "video_category"


  resources :videos
  root :to => 'home#index'
end
