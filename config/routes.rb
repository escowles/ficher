Rails.application.routes.draw do
  root to: "works#index"

  resources :pages
  resources :sheets
  resources :works
end
