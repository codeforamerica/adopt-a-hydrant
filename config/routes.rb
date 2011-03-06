AdoptAHydrant::Application.routes.draw do
  post "/sign_up.:format" => "users#sign_up", :as => "sign_up"
  post "/sign_in.:format" => "users#sign_in", :as => "sign_in"
  post "/forgot_password.:format" => "users#forgot_password", :as => "forgot_password"
  root :to => "main#index"
end
