AdoptAHydrant::Application.routes.draw do
  devise_for :users, :controllers => {
    :passwords => 'passwords',
    :registrations => 'users',
    :sessions => 'sessions',
  }
  resource :user
  resource :hydrant
  get 'sitemap(.format)' => 'sitemaps#index', :as => 'sitemap'
  root :to => 'main#index'
end
