require 'rails_helper'

RSpec.describe ::Clients::List, type: :case do
  subject(:result) do
    described_class.call(
      collection: clients,
      q: query
    )
  end

  describe '.call' do
    let(:clients) { create_list(:client, 3) }

    context 'when the query is nil' do
      let(:query) { nil }

      it 'returns all contacts' do
        expect(result.data[:clients]).to eq(clients)
        expect(result).to be_success
        expect(result.data[:message]).to eq('Listado com Sucesso!')
      end
    end

    context 'when the query is present' do
      let(:query) { clients.first.name }

      it 'returns the clients that match the query' do
        expect(result.data[:clients].first.name).to eq(query)
        expect(result).to be_success
        expect(result.data[:message]).to eq('Listado com Sucesso!')
      end
    end

    context 'when no clients match the query' do
      let(:query) { 'nonexistent' }

      it 'returns an empty array' do
        expect(result.data[:clients]).to be_empty
        expect(result).to be_success
        expect(result.data[:message]).to eq('Listado com Sucesso!')
      end
    end

    context 'when an error occurs' do
      let(:query) { nil }
      before do
        allow(Client).to receive(:all).and_raise(StandardError, 'Database error')
      end

      it 'returns a failure result with an error message' do
        expect(result).to be_failure
        expect(result.data[:message]).to eq('Não foi possivel listar!')
        expect(result.data[:error]).to include('Database error')
      end
    end

    context 'when the query is an empty string' do
      let(:query) { '' }

      it 'returns all clients' do
        expect(result.data[:clients]).to eq(clients)
      end
    end

    context 'when the query is a whitespace string' do
      let(:query) { '   ' }

      it 'returns all clients' do
        expect(result.data[:clients]).to eq(clients)
      end
    end
  end
end
