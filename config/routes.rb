Rails.application.routes.draw do
  get 'users/new'
  get 'users/show'
  get 'users/edit'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'
  get 'articles', to: 'articles#index'
  get 'article/:id', to: 'articles#show', as: :article
end
