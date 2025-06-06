require 'swagger_helper'

RSpec.describe 'Api::V1::Sales', type: :request do
  let(:user) { create :user }
  before do
    sign_in(user)
  end

  path '/api/v1/sales' do
    post 'Create a sale' do
      tags 'Sales'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :sale, in: :body, schema: {
        type: :object,
        properties: {
          client_id: { type: :integer },
          sale_date: { type: :date },
          value: { type: :decimal },
        },
        required: ['client_id', 'sale_date', 'value']
      }

      response '201', 'Sale created' do
        let(:sale) { { client_id: create(:client).id, value: 100.0, sale_date: Date.today } }
        run_test!
      end

      response '422', 'Invalid request' do
        let(:sale) { { client_id: nil } }
        run_test!
      end
    end
  end
end
