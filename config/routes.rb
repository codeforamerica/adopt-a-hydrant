Rails.application.routes.draw do
  devise_for :users, controllers: {
    passwords: 'passwords',
    registrations: 'users',
    sessions: 'sessions',
  }
  devise_scope :user do
    get '/users/mailing_address', to: 'users#mailing_address', as: 'mailing_address'
    get '/users/survey', to: 'users#survey', as: 'survey'
    put '/users/restricted', to: 'users#restricted_update', as: 'restricted_user_update'
  end

  get '/address', to: 'addresses#show', as: 'address'
  get '/info_window', to: 'info_window#index', as: 'info_window'
  get '/sitemap', to: 'sitemaps#index', as: 'sitemap'

  scope '/sidebar', controller: :sidebar do
    get :search, as: 'search'
    get :combo_form, as: 'combo_form'
    get :edit_profile , as: 'edit_profile'
  end

  resource :reminders
  resource :things
  resource :promo_codes, only: [:update]
  get '/promo_codes/use', to: 'promo_codes#use', as: 'promo_codes_use'
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  root to: 'main#index'
end
