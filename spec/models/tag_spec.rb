require 'rails_helper'

RSpec.describe Tag, type: :model do
  it 'name require' do
    tag = Tag.create
    expect(tag.errors.details[:name][0][:error]).to eq(:blank)
    expect(tag.errors[:name][0]).to eq('标签名不能为空')
  end
end
