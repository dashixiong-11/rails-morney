class Tag < ApplicationRecord
  has_many :taggings
  has_many :records, through: :taggings
  belongs_to :user
  validates_presence_of :name
  # validates_uniqueness_of :name
end
