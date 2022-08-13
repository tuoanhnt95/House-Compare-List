Rails.application.routes.draw do
  root to: "pages#home"
  resources :house_lists do
    resources :houses
  end

  resources :houses, only: [] do
    resources :reviews
  end
end
