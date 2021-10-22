class Tag < ApplicationRecord
  has_many :taggings
  has_many :records, through: :taggings
  validates_presence_of :name
  validates_uniqueness_of :name
end
