AdoptAHydrant::Application.routes.draw do
  get "javascripts/:action" => "javascripts#action"
  root :to => "welcome#index"
end
