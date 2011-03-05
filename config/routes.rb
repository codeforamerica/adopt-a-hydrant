AdoptAHydrant::Application.routes.draw do
  get "/javascripts/:action" => "javascripts#action"
  post "/sign_up.:format" => "main#sign_up"
  post "/sign_in.:format" => "main#sign_in"
  post "/forgot_password.:format" => "main#forgot_password"
  root :to => "main#index"
end
