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
  # Exemplo de rota protegida que exigirá autenticação JWT
  # namespace :api do
  #   namespace :v1 do
  #     resources :articles, only: [:index, :show, :create, :update, :destroy] do
  #       # Exemplo de como proteger uma rota dentro de resources
  #       before_action :authenticate_user!, only: [:create, :update, :destroy]
  #     end
  #   end
  # end
  namespace :api do
    namespace :v1 do
      # Rota de autenticação
      # Rotas para CRUD de clientes
      resources :clients, only: [:index, :show, :create, :update, :destroy]

      # Rotas para criação de vendas
      resources :sales, only: [:create]

      # Rotas de estatísticas
      get '/statistics/sales_by_day', to: 'statistics#sales_by_day'
      get '/statistics/top_clients', to: 'statistics#top_clients'
    end
  end
end
