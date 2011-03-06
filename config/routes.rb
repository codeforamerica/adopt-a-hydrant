AdoptAHydrant::Application.routes.draw do
  devise_for :users
  root :to => "main#index"
end
