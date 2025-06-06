require 'swagger_helper'

RSpec.describe 'Api::V1::Statistics', type: :request do
  let(:user) { create :user }
  let!(:client) { create :client }
  let!(:sales) { create_list(:sale, 3, client: client) }


  before do
    sign_in(user)
  end

  path '/api/v1/statistics' do
    get 'List statistics' do
      tags 'Statistics'
      produces 'application/json'

      response '200', 'Statistics retrieved successfully' do
        run_test! do |response|
          data = JSON.parse(response.body, symbolize_names: true)
          expect(data[:message]).to eq('Estatísticas geradas com sucesso!')
          expect(data[:data][:sales_by_day]).to be_an(Array)
        end
      end
    end
  end
end
