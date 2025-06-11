Rails.application.routes.draw do
  root "feed#index"
  get "register" => "users#new", as: "register"
  post "register" => "users#create"
  get "up" => "rails/health#show", as: :rails_health_check
  
end
