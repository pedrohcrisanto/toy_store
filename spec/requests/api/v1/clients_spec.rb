require 'swagger_helper'

RSpec.describe 'API V1 Clients', type: :request do
  let(:user) { create :user }
  before do
    sign_in(user)
  end

  path '/api/v1/clients' do
    get 'List all clients' do
      tags 'Clients'
      security [ cookie: [] ]
      consumes 'application/json'

      response '200', 'contacts found' do
        let(:clients) { create_list(:client, 20) }

        run_test!
      end
    end

    post 'Create a client' do
      tags 'Clients'
      security [ cookie: [] ]
      consumes 'application/json'
      parameter name: :client, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          date_of_birth: { type: :date },
        },
        required: ['name', 'email']
      }

      response '201', 'client created' do
        let(:client) { { name: 'John Doe', email: 'pedro@pedro.com', date_of_birth: Date.today } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['data']['name']).to eq('John Doe')
          expect(data['data']['email']).to eq('pedro@pedro.com')
          expect(data['data']['date_of_birth']).to eq(Date.today.as_json)
          expect(data['message']).to eq('Cliente criado com sucesso!')
        end
      end
    end
  end

  path '/api/v1/clients/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'Client ID'

    get 'Show a client' do
      tags 'Clients'
      security [ cookie: [] ]
      consumes 'application/json'

      response '200', 'client found' do
        let(:client) { create(:client) }
        let(:id) { client.id }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['data']['id']).to eq(client.id)
          expect(data['message']).to eq('Cliente encontrado com sucesso!')
        end
      end

      response '404', 'client not found' do
        let(:id) { 'nonexistent' }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['message']).to eq('Não foi possível encontrar o cliente!')
        end
      end
    end

    patch 'Update a client' do
      tags 'Clients'
      security [ cookie: [] ]
      consumes 'application/json'
      parameter name: :client, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          date_of_birth: { type: :date },
        },
        required: ['name', 'email']
      }

      response '200', 'client updated' do
        let(:id) { create(:client).id }
        let(:client) { { name: 'Jane Doe', email: 'pedro@pedro.com', date_of_birth: Date.today } }

        run_test!
      end
    end

    delete 'Delete a client' do
      tags 'Clients'
      security [ cookie: [] ]
      consumes 'application/json'

      response '200', 'client deleted' do
        let(:client) { create(:client) }
        let(:id) { client.id }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['data']['id']).to eq(client.id)
          expect(data['message']).to eq('Cliente removido com sucesso!')
        end
      end

      response '404', 'client not found' do
        let(:id) { 'nonexistent' }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['message']).to eq('Não foi possível remover o cliente!')
        end
      end
    end
  end
end
