Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  get "users/show", to: "users#show", as: "users_show"
end
