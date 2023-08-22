Rails.application.routes.draw do
  root "home#top"
  post "/auth/github/callback", to: "sessions#create", as: :login
  delete "/logout", to: "sessions#destroy", as: :logout
  get "/auth/failure", to: "sessions#failure", as: :auth_failure
end
