Rails.application.routes.draw do
  root "home#top"
  get 'auth/:provider/callback', to: 'sessions#create'
  get '/login', to: 'sessions#new'
end
