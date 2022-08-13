Rails.application.routes.draw do
  root to: "pages#home"
  resources :house_lists do
    resources :houses_n_house_lists, only: []
  end

  resources :houses do
    resources :reviews
  end
end
