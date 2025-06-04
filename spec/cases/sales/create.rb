require 'rails_helper'

RSpec.describe ::Sales::Create, type: :case do
  subject(:result) do
    described_class.call(params: sales_params
    )
  end
  let!(:client) { create(:client) }
  let!(:sales_params) { attributes_for(:sale, client_id: client.id) }

  describe '.call' do
    context 'when the sale is valid' do
      it 'creates a new sale and returns success' do
        expect { result }.to change(Sale, :count).by(1)
        expect(result).to be_success
        expect(result.data[:message]).to eq('Compra criado com sucesso!')
      end
    end
  end
end
