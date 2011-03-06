AdoptAHydrant::Application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users',
    :sessions => 'sessions'
  }
  resource :user
  root :to => 'main#index'
end
