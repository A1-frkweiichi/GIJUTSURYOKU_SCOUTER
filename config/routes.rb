Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  get "home/top", to: "home#top", as: "home_top"
end
