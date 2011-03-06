AdoptAHydrant::Application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users',
    :sessions => 'sessions'
  }
  resource :user
  get 'sitemap(.format)' => 'sitemaps#index', :as => 'sitemap'
  root :to => 'main#index'
end
