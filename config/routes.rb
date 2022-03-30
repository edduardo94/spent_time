Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
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
      post "times", to: "spent_hours#create"
      get "times/:project_id", to: "spent_hours#show"
      put "times/:id", to: "spent_hours#update"
    end
  end
end
