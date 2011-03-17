AdoptAHydrant::Application.routes.draw do
  devise_for :users, :controllers => {
    :passwords => 'passwords',
    :registrations => 'users',
    :sessions => 'sessions',
  }
  resource :user
  resource :hydrant
  get 'sitemap' => 'sitemaps#index', :as => 'sitemap'
  get 'forms' => 'forms#index', :as => 'forms'
  root :to => 'main#index'
end
