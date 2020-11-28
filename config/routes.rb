Rails.application.routes.draw do
  root to: "works#index"

  resources :works
  resources :sheets
  resources :pages

  get "/works/:work_id/sheet/new", to: "sheets#new", as: "new_work_sheet"
end
