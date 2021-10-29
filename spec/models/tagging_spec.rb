require 'rails_helper'

RSpec.describe Tagging, type: :model do
  before :each do
    @user = create(:user)
  end
  it '必须传 record' do
    tag = Tag.create! name: 'test'
    tagging = Tagging.create tag: tag
    expect(tagging.errors.details[:record][0][:error]).to eq(:blank)
    expect(tagging.errors[:record][0]).to eq('记录不能为空')
  end

  it '必须传 tag' do
    record = create :record
    tagging = Tagging.create record: record
    expect(tagging.errors.details[:tag][0][:error]).to eq(:blank)
    expect(tagging.errors[:tag][0]).to eq('标签不能为空')
  end

  it 'create tagging' do
    tag = Tag.create! name: 'test'
    record = create :record
    tagging = Tagging.create record: record, tag: tag
    expect(tag.records.first.id).to eq record.id
    expect(record.tags.first.id).to eq tag.id
    expect(tagging.record_id).to eq record.id
    expect(tagging.tag_id).to eq tag.id
  end

  it 'records and tags' do
    tag1 = Tag.create! name: 'test1'
    tag2 = Tag.create! name: 'test2'
    record1 = create :record
    record2 = create :record
    Tagging.create record: record1, tag: tag1
    Tagging.create record: record2, tag: tag2
    Tagging.create record: record1, tag: tag2
    Tagging.create record: record2, tag: tag1
    expect(tag1.records.count).to eq 2
    expect(tag2.records.count).to eq 2
    expect(record1.tags.count).to eq 2
    expect(record2.tags.count).to eq 2
  end
end
