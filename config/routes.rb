# config/routes.rb

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }

  namespace :api do
    namespace :v1 do
      # Rota de autenticação
      # Rotas para CRUD de clientes
      resources :clients, only: [:index, :show, :create, :update, :destroy]

      # Rotas para criação de vendas
      resources :sales, only: [:create]

      # Rotas de estatísticas
      get '/statistics', to: 'statistics#index'
    end
  end
end
