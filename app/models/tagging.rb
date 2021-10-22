class Tagging < ApplicationRecord
  belongs_to :tag #跟tag表 以及record表关联
  belongs_to :record
  validates_presence_of :record_id, :tag_id
end
