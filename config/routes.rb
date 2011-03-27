AdoptAHydrant::Application.routes.draw do
  devise_for :users, :controllers => {
    :passwords => 'passwords',
    :registrations => 'users',
    :sessions => 'sessions',
  }
  get 'hydrants' => 'hydrants#list'
  resource :hydrant
  get 'address' => 'addresses#show'
  get 'sitemap' => 'sitemaps#index', :as => 'sitemap'
  root :to => 'main#index'
end
