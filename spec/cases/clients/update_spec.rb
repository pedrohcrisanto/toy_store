require 'rails_helper'

RSpec.describe ::Clients::Update, type: :case do
  subject(:result) do
    described_class.call(
      id: client_id,
      params: update_params
    )
  end

  describe '.call' do
    let(:client) { create(:client) }
    let(:client_id) { client.id }
    let(:update_params) { { name: 'Updated Name' } }

    context 'when the client exists and is updated successfully' do
      it 'returns the updated client' do
        expect(result.data[:client].name).to eq('Updated Name')
        expect(result).to be_success
        expect(result.data[:message]).to eq('Cliente atualizado com sucesso!')
      end
    end

    context 'when the client does not exist' do
      let(:client_id) { -1 }

      it 'returns a failure result with an error message' do
        expect(result).to be_failure
        expect(result.data[:message]).to eq('Não foi possível atualizar o cliente!')
      end
    end

    context 'when the update fails due to validation errors' do
      let(:update_params) { { email: 'invalid-email' } }

      it 'returns a failure result with validation errors' do
        expect(result).to be_failure
        expect(result.data[:message]).to eq('Não foi possível atualizar o cliente!')
      end
    end

    context 'when an error occurs during update' do
      before do
        allow(Client).to receive(:find).and_raise(StandardError, 'Database error')
      end

      it 'returns a failure result with an error message' do
        expect(result).to be_failure
        expect(result.data[:message]).to eq('Não foi possível atualizar o cliente!')
        expect(result.data[:error]).to include('Database error')
      end
    end
  end
end
