AdoptAHydrant::Application.routes.draw do
  devise_for :users, :controllers => {
    :passwords => 'passwords',
    :registrations => 'users',
    :sessions => 'sessions',
  }
  get 'address' => 'addresses#show', :as => 'address'
  get 'info_window' => 'info_window#index', :as => 'info_window'
  get 'sitemap' => 'sitemaps#index', :as => 'sitemap'
  resource :hydrants
  resource :reminders
  root :to => 'main#index'
end
