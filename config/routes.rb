Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "authenticate", to: "auth#authenticate"
    end
  end
end
