# spec/models/client_spec.rb
require 'rails_helper'

RSpec.describe Client, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_presence_of(:date_of_birth) }
  it { should have_many(:sales).dependent(:destroy) }

  it 'should validate email format' do
    client = build(:client, email: 'invalid-email')
    expect(client).to_not be_valid
    expect(client.errors[:email]).to include('is invalid')
  end
end
