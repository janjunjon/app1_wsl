Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'
  get 'articles', to: 'articles#index'
  get 'article/:id', to: 'articles#show', as: :article
  get 'articles/search', to: 'articles#search', as: :search
  resources :users
end
