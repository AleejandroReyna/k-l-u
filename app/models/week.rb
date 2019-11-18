class Week < ApplicationRecord
  validates_presence_of :week
  has_many :days, dependent: :destroy
end
