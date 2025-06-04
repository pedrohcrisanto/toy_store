require 'rails_helper'

RSpec.describe ::Statistics::List, type: :case do
  subject(:result) do
    described_class.call
  end

  describe '.call' do
    context 'when there are sales' do
      let!(:sales) { create_list(:sale, 3) }

      it 'returns the total sales count and total revenue' do
        expect(result.data[:sales_by_day].count).to eq(3)
        expect(result).to be_success
        expect(result.data[:message]).to eq('Estatísticas geradas com sucesso!')
      end
    end
  end
end
