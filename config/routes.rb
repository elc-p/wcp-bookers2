Rails.application.routes.draw do
  root to: 'homes#top'
  get "home/about" => "homes#about" , as: "about"

  devise_for :users
  resources :books do
    resources :users
  end
  
  resources :homes
  
  
end
