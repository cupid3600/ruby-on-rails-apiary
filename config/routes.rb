Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount_devise_token_auth_for 'User', at: '/api/v1/users', controllers: {
    registrations:  'api/v1/registrations',
    sessions:  'api/v1/sessions',
    passwords:  'api/v1/passwords'
  }

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      devise_scope :user do
        get :status, to: 'api#status'
        resources :users, only: :show
        resource :user, only: :update do
          get :profile
        end
        resources :constellations, only: :index do
          collection do
            get :search
          end
          member do
            get :summary
            get :popular
            get :about_to_expire
            get :common
          end
        end
        resources :constellation_requests, only: :create
        resources :contents, only: %i(create index) do
          member do
            post :flag
            post :favorite
            put :constellations, to: 'contents#update_constellations'
          end
          collection do
            get :favorites
          end
        end
        resources :goals
        resources :planets
        scope :shooting_stars, controller: :shooting_stars do
          get :show_one
          get :count
        end
      end
    end
  end

  mount ActionCable.server => '/cable'
end
