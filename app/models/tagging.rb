class Tagging < ApplicationRecord
  belongs_to :tag, required: true #跟tag表 以及record表关联
  belongs_to :record, required: true
  belongs_to :user, required: true
end
