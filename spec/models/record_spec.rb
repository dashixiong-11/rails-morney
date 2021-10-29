require 'rails_helper'

RSpec.describe Record, type: :model do
  before :each do
    @user = create(:user)
  end
  it 'amount is required' do
    record = build :record, amount: nil
    record.validate
    expect(record.errors.details[:amount][0][:error]).to eq :blank
  end
  it 'category can only be income or outgoings' do
    expect {
      create :record, category: 'xxx'
    }.to raise_error(ArgumentError)
  end
end
