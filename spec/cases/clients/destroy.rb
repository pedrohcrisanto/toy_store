require 'rails_helper'

RSpec.describe ::Clients::Destroy, type: :case do
  let!(:client) { create(:client) }

  subject(:result) do
    described_class.call(
      id: client_id
    )
  end

  describe '.call' do
    let(:client_id) { client.id }

    context 'when the client exists' do
      it 'deletes the client and returns success' do
        expect { result }.to change(Client, :count).by(-1)
        expect(result).to be_success
        expect(result.data[:message]).to eq('Cliente removido com sucesso!')
      end
    end

    context 'when the client does not exist' do
      let(:client_id) { -1 }

      it 'returns a failure result with an error message' do
        expect { result }.not_to change(Client, :count)
        expect(result).to be_failure
        expect(result.data[:message]).to eq('Não foi possível remover o cliente!')
      end
    end
  end
end
