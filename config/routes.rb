AdoptAHydrant::Application.routes.draw do
  devise_for :users, :controllers => {
    :passwords => 'passwords',
    :registrations => 'users',
    :sessions => 'sessions',
  }
  resource :user
  get 'hydrants' => 'hydrants#index'
  resource :hydrant
  scope 'javascripts', :controller => 'javascripts', :as => 'javascripts' do
    get 'main', :action => 'main', :as => 'main'
  end
  get 'address' => 'addresses#index', :as => 'address'
  get 'sitemap' => 'sitemaps#index', :as => 'sitemap'
  get 'contents' => 'contents#index', :as => 'contents'
  root :to => 'main#index'
end
