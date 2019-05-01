Rails.application.routes.draw do
  resources :articles do
    resources :questions
  end

  root "articles#index"
end
