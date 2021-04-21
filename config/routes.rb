Rails.application.routes.draw do
  get '/lagis', to: 'codes#index', as: :lagis
  post '/lagis', to: 'codes#post', as: :lagis_post
  get '/lagis/delete', to: 'codes#delete'
  delete '/lagis/delete', to: 'codes#destroy'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'
  get 'articles', to: 'articles#index'
  get 'article/:id', to: 'articles#show', as: :article
  get 'articles/search', to: 'articles#search', as: :search
  get 'account_activations/:token/edit', to: 'account_activations#edit'
  resources :users
end
