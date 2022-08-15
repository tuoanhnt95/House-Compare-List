Rails.application.routes.draw do
  root to: "pages#home"
  resources :house_lists
  resources :houses, only: %i[index new show create]
end
