require 'rails_helper'

RSpec.describe ::Clients::Show, type: :case do
  subject(:result) do
    described_class.call(
      id: client_id
    )
  end

  describe '.call' do
    let(:client) { create(:client) }
    let(:client_id) { client.id }

    context 'when the client exists' do
      it 'returns the client' do
        expect(result.data[:client]).to eq(client)
        expect(result).to be_success
        expect(result.data[:message]).to eq('Cliente encontrado com sucesso!')
      end
    end

    context 'when the client does not exist' do
      let(:client_id) { -1 }

      it 'returns a failure result with an error message' do
        expect(result).to be_failure
        expect(result.data[:message]).to eq('Não foi possível encontrar o cliente!')
      end
    end

    context 'when an error occurs during retrieval' do
      before do
        allow(Client).to receive(:find).and_raise(StandardError, 'Database error')
      end

      it 'returns a failure result with an error message' do
        expect(result).to be_failure
        expect(result.data[:message]).to eq('Não foi possível encontrar o cliente!')
        expect(result.data[:error]).to include('Database error')
      end
    end
  end
end
