require 'rails_helper'

RSpec.describe ::Clients::Create, type: :case do
  subject(:result) do
    described_class.call(
      collection: clients,
      params: client_params
    )
  end

  describe '.call' do
    let(:clients) { Client.all }
    let(:client_params) { attributes_for(:client) }

    context 'when the client is valid' do
      it 'creates a new client' do
        expect { result }.to change(Client, :count).by(1)
        expect(result.data[:client]).to be_persisted
        expect(result).to be_success
        expect(result.data[:message]).to eq('Cliente criado com sucesso!')
      end
    end

    context 'when the client is invalid' do
      let(:client_params) { attributes_for(:client, name: nil) }

      it 'does not create a new client' do
        expect { result }.not_to change(Client, :count)
        expect(result).to be_failure
        expect(result.data[:message]).to eq('Não foi possível criar o cliente!')
        expect(result.data[:error]).to include("Name can't be blank")
      end
    end

    context 'when an error occurs during creation' do
      before do
        allow(Client).to receive(:create!).and_raise(StandardError, 'Database error')
      end

      it 'returns a failure result with an error message' do
        expect(result).to be_failure
        expect(result.data[:message]).to eq('Não foi possível criar o cliente!')
        expect(result.data[:error]).to include('Database error')
      end
    end
  end
end
