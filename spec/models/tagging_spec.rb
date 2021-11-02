require 'rails_helper'

RSpec.describe Tagging, type: :model do
  before :each do
    @user = create(:user)
  end
  it '必须传 record' do
    tag = create :tag
    tagging = Tagging.create tag: tag, user: @user
    expect(tagging.errors.details[:record][0][:error]).to eq(:blank)
    expect(tagging.errors[:record][0]).to eq('记录不能为空')
  end

  it '必须传 tag' do
    record = create :record
    tagging = Tagging.create record: record, user: @user
    expect(tagging.errors.details[:tag][0][:error]).to eq(:blank)
    expect(tagging.errors[:tag][0]).to eq('标签不能为空')
  end

  it 'create tagging' do
    tag = create :tag
    record = create :record
    tagging = Tagging.create record: record, tag: tag, user: @user
    expect(tag.records.first.id).to eq record.id
    expect(record.tags.first.id).to eq tag.id
    expect(tagging.record_id).to eq record.id
    expect(tagging.tag_id).to eq tag.id
  end

  it 'records and tags' do
    tag1 = create :tag
    tag2 = create :tag
    record1 = create :record
    record2 = create :record
    Tagging.create record: record1, tag: tag1, user: @user
    Tagging.create record: record2, tag: tag2, user: @user
    Tagging.create record: record1, tag: tag2, user: @user
    Tagging.create record: record2, tag: tag1, user: @user
    expect(tag1.records.count).to eq 2
    expect(tag2.records.count).to eq 2
    expect(record1.tags.count).to eq 2
    expect(record2.tags.count).to eq 2
  end
end
