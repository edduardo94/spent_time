Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "users/:id", to: "users#show"
      put "users/:id", to: "users#update"
      post "users", to: "users#create"
      post "authenticate", to: "auth#authenticate"
    end
  end
end
