require 'rails_helper'

RSpec.describe Sale, type: :model do
  it { should validate_presence_of(:value) }
  it { should validate_presence_of(:sale_date) }
  it { should belong_to(:client) }

  it 'should validate value is greater than zero' do
    sale = build(:sale, value: -10)
    expect(sale).to_not be_valid
    expect(sale.errors[:value]).to include('must be greater than 0')
  end

  it 'should validate date is not in the future' do
    sale = build(:sale, sale_date: Date.tomorrow)
    expect(sale).to_not be_valid
    expect(sale.errors[:sale_date]).to include('cannot be in the future')
  end
end
