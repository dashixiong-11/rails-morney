require 'rails_helper'

RSpec.describe Record, type: :model do
  it 'amount is required' do
    record = Record.create notes: '备注', category: 'outgoings'
    expect(record.errors.details[:amount][0][:error]).to eq :blank
  end
  it 'category can only be income or outgoings' do
    expect {
      Record.create amount: 10000, notes: '备注', category: 'xxx'
    }.to raise_error(ArgumentError)
  end
end
