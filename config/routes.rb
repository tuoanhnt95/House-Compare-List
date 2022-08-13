Rails.application.routes.draw do
  root to: "pages#home"
  resources :house_lists
  resources :houses
end
