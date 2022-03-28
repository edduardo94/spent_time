Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "users/:id", to: "users#show"
      put "users/:id", to: "users#update"
      post "users", to: "users#create"
      post "projects", to: "projects#create"
      get "projects", to: "projects#list"
      get "projects/:id", to: "projects#show"
      put "projects/:id", to: "projects#update"
      post "authenticate", to: "auth#authenticate"
    end
  end
end
